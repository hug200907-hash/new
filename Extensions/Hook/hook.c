#include "hook.h"
#include "mach_excServer.h"
#include <CoreFoundation/CoreFoundation.h>
#include <dlfcn.h>
#include <mach-o/dyld_images.h>
#include <mach-o/nlist.h>
#include <mach/mach.h>
#include <pthread.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/sysctl.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static struct {
    mach_port_t srv; 
    mach_port_t ohp; 
    bool init;       
    bool t_init;   
    struct {
        uintptr_t src;
        uintptr_t dst;
    } targets[16];
    int active; 
    pthread_rwlock_t rwlock;
    uint32_t xor_key;
} ctx = {0};

static inline char* obfuscate_str(const char* str) {
    if (!ctx.xor_key) return NULL;
    size_t len = strlen(str);
    char* result = malloc(len + 1);
    if (!result) return NULL;
    for (size_t i = 0; i < len; i++) {
        result[i] = str[i] ^ ((ctx.xor_key >> ((i % 4) * 8)) & 0xFF);
    }
    result[len] = '\0';
    return result;
}

static inline char* deobfuscate_str(const char* str) {
    return obfuscate_str(str);
}

static int compare_targets(const void *a, const void *b) {
    const struct { uintptr_t src; uintptr_t dst; } *ta = a;
    const struct { uintptr_t src; uintptr_t dst; } *tb = b;
    return (ta->src > tb->src) - (ta->src < tb->src);
}

kern_return_t catch_mach_exception_raise(
    mach_port_t exception_port,
    mach_port_t thread,
    mach_port_t task,
    exception_type_t exception,
    mach_exception_data_t code,
    mach_msg_type_number_t codeCnt) {
    return KERN_FAILURE;
}

kern_return_t catch_mach_exception_raise_state_identity(
    mach_port_t exception_port,
    mach_port_t thread,
    mach_port_t task,
    exception_type_t exception,
    mach_exception_data_t code,
    mach_msg_type_number_t codeCnt,
    int *flavor,
    thread_state_t old_state,
    mach_msg_type_number_t old_stateCnt,
    thread_state_t new_state,
    mach_msg_type_number_t *new_stateCnt) {
    return KERN_FAILURE;
}

kern_return_t catch_mach_exception_raise_state(
    mach_port_t exception_port,
    exception_type_t exception,
    const mach_exception_data_t code,
    mach_msg_type_number_t codeCnt,
    int *flavor,
    const thread_state_t old_state,
    mach_msg_type_number_t old_stateCnt,
    thread_state_t new_state,
    mach_msg_type_number_t *new_stateCnt) {
    if (exception != EXC_BREAKPOINT) return KERN_FAILURE;
    arm_thread_state64_t *old = (arm_thread_state64_t *)old_state;
    arm_thread_state64_t *new = (arm_thread_state64_t *)new_state;
    uintptr_t pc = arm_thread_state64_get_pc(*old);
    pthread_rwlock_rdlock(&ctx.rwlock);
    struct { uintptr_t src; uintptr_t dst; } key = { pc, 0 };
    struct { uintptr_t src; uintptr_t dst; } *found = bsearch(&key, ctx.targets, ctx.active, sizeof(ctx.targets[0]), compare_targets);
    if (found) {
        *new = *old;
        *new_stateCnt = old_stateCnt;
        arm_thread_state64_set_pc_fptr(*new, found->dst);
        pthread_rwlock_unlock(&ctx.rwlock);
        return KERN_SUCCESS;
    }
    pthread_rwlock_unlock(&ctx.rwlock);
    return KERN_FAILURE;
}

static void* exception_handler(void *unused) {
    char thread_name[32];
    snprintf(thread_name, sizeof(thread_name), "com.apple.%x", (unsigned)time(NULL) & 0xFFFF);
    pthread_setname_np(thread_name);
    while (1) {
        mach_msg_server(mach_exc_server, 
                        sizeof(union __RequestUnion__catch_mach_exc_subsystem), 
                        ctx.srv, 
                        MACH_MSG_OPTION_NONE);
    }
    return NULL;
}

static bool initialize_hook_system(void) {
    ctx.xor_key = (uint32_t)time(NULL) ^ (uint32_t)getpid();
    pthread_rwlock_init(&ctx.rwlock, NULL);
    int breakpoints = 0;
    size_t size = sizeof(breakpoints);
    sysctlbyname("hw.optional.breakpoint", &breakpoints, &size, NULL, 0);
    mach_port_t current_ports[EXC_TYPES_COUNT];
    mach_msg_type_number_t port_count = EXC_TYPES_COUNT;
    exception_mask_t masks[EXC_TYPES_COUNT];
    exception_behavior_t behaviors[EXC_TYPES_COUNT];
    thread_state_flavor_t flavors[EXC_TYPES_COUNT];
    if (task_get_exception_ports(mach_task_self(), EXC_MASK_BREAKPOINT, 
                                 masks, &port_count, current_ports, 
                                 behaviors, flavors) == KERN_SUCCESS) {
        if (port_count > 0) ctx.ohp = current_ports[0];
    }
    if (mach_port_allocate(mach_task_self(), MACH_PORT_RIGHT_RECEIVE, &ctx.srv) != KERN_SUCCESS) return false;
    if (mach_port_insert_right(mach_task_self(), ctx.srv, ctx.srv, 
                               MACH_MSG_TYPE_MAKE_SEND) != KERN_SUCCESS) {
        mach_port_deallocate(mach_task_self(), ctx.srv);
        return false;
    }
    if (task_set_exception_ports(mach_task_self(), EXC_MASK_BREAKPOINT, 
                                 ctx.srv, EXCEPTION_STATE | MACH_EXCEPTION_CODES, 
                                 ARM_THREAD_STATE64) != KERN_SUCCESS) {
        mach_port_deallocate(mach_task_self(), ctx.srv);
        return false;
    }
    if (!ctx.t_init) {
        pthread_attr_t attr;
        pthread_attr_init(&attr);
        pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
        pthread_t thread;
        pthread_create(&thread, &attr, exception_handler, NULL);
        pthread_attr_destroy(&attr);
        ctx.t_init = true;
    }
    return true;
}

static bool apply_breakpoints_to_threads(arm_debug_state64_t *state) {
    thread_act_array_t threads;
    mach_msg_type_number_t thread_count = 0;
    kern_return_t kr = task_threads(mach_task_self(), &threads, &thread_count);
    if (kr != KERN_SUCCESS) return false;
    bool success = true;
    for (int i = 0; i < thread_count; ++i) {
        if (thread_set_state(threads[i], ARM_DEBUG_STATE64, 
                             (thread_state_t)state, 
                             ARM_DEBUG_STATE64_COUNT) != KERN_SUCCESS) {
            success = false;
        }
    }
    for (int i = 0; i < thread_count; ++i) {
        mach_port_deallocate(mach_task_self(), threads[i]);
    }
    vm_deallocate(mach_task_self(), (vm_address_t)threads, thread_count * sizeof(*threads));
    return success;
}

bool hook(void *old[], void *new[], int count) {
    if (count > 6 || count <= 0) return false;
    pthread_rwlock_wrlock(&ctx.rwlock);
    if (!ctx.init) {
        if (!initialize_hook_system()) {
            pthread_rwlock_unlock(&ctx.rwlock);
            return false;
        }
        ctx.init = true;
    }
    arm_debug_state64_t state = {};
    mach_msg_type_number_t state_count = ARM_DEBUG_STATE64_COUNT;
    if (task_get_state(mach_task_self(), ARM_DEBUG_STATE64, 
                       (thread_state_t)&state, &state_count) != KERN_SUCCESS) {
        pthread_rwlock_unlock(&ctx.rwlock);
        return false;
    }
    int added = 0;
    for (int i = 0; i < count; i++) {
        bool exists = false;
        for (int j = 0; j < ctx.active; j++) {
            if (ctx.targets[j].src == (uintptr_t)old[i]) {
                exists = true;
                ctx.targets[j].dst = (uintptr_t)new[i];
                break;
            }
        }
        if (!exists) {
            int slot = -1;
            for (int j = 0; j < 6; j++) {
                if (state.__bvr[j] == 0) {
                    slot = j;
                    break;
                }
            }
            if (slot == -1) continue;
            state.__bvr[slot] = (uintptr_t)old[i];
            state.__bcr[slot] = 0x1e5;
            if (ctx.active < 16) {
                ctx.targets[ctx.active].src = (uintptr_t)old[i];
                ctx.targets[ctx.active].dst = (uintptr_t)new[i];
                ctx.active++;
                added++;
            }
        }
    }
    if (added > 0) {
        qsort(ctx.targets, ctx.active, sizeof(ctx.targets[0]), compare_targets);
    }
    bool success = true;
    if (task_set_state(mach_task_self(), ARM_DEBUG_STATE64, 
                       (thread_state_t)&state, ARM_DEBUG_STATE64_COUNT) != KERN_SUCCESS) {
        success = false;
    }
    if (success) {
        success = apply_breakpoints_to_threads(&state);
    }
    pthread_rwlock_unlock(&ctx.rwlock);
    return success;
}

bool hook_reset(void *o[], void *n[], int c) {
    if (c > 6 || c <= 0) return false;
    pthread_rwlock_wrlock(&ctx.rwlock);
    if (!ctx.init) {
        if (!initialize_hook_system()) {
            pthread_rwlock_unlock(&ctx.rwlock);
            return false;
        }
        ctx.init = true;
    }
    arm_debug_state64_t state = {};
    mach_msg_type_number_t state_count = ARM_DEBUG_STATE64_COUNT;
    if (task_get_state(mach_task_self(), ARM_DEBUG_STATE64, 
                       (thread_state_t)&state, &state_count) != KERN_SUCCESS) {
        pthread_rwlock_unlock(&ctx.rwlock);
        return false;
    }
    bool need_update = false;
    for (int i = 0; i < c; i++) {
        bool found = false;
        for (int j = 0; j < ctx.active; j++) {
            if (ctx.targets[j].src == (uintptr_t)o[i]) {
                ctx.targets[j].dst = (uintptr_t)n[i];
                found = true;
                break;
            }
        }
        if (!found) {
            int slot = -1;
            for (int j = 0; j < 6; j++) {
                if (state.__bvr[j] == 0) {
                    slot = j;
                    break;
                }
            }
            if (slot != -1 && ctx.active < 16) {
                state.__bvr[slot] = (uintptr_t)o[i];
                state.__bcr[slot] = 0x1e5;
                ctx.targets[ctx.active].src = (uintptr_t)o[i];
                ctx.targets[ctx.active].dst = (uintptr_t)n[i];
                ctx.active++;
                need_update = true;
            }
        }
    }
    if (need_update) {
        qsort(ctx.targets, ctx.active, sizeof(ctx.targets[0]), compare_targets);
        if (task_set_state(mach_task_self(), ARM_DEBUG_STATE64, 
                           (thread_state_t)&state, ARM_DEBUG_STATE64_COUNT) != KERN_SUCCESS) {
            pthread_rwlock_unlock(&ctx.rwlock);
            return false;
        }
        apply_breakpoints_to_threads(&state);
    }
    pthread_rwlock_unlock(&ctx.rwlock);
    return true;
}

bool unhook(void *old[], int count) {
    if (count <= 0) return false;
    pthread_rwlock_wrlock(&ctx.rwlock);
    if (!ctx.init || ctx.active == 0) {
        pthread_rwlock_unlock(&ctx.rwlock);
        return true;
    }
    arm_debug_state64_t state = {};
    mach_msg_type_number_t state_count = ARM_DEBUG_STATE64_COUNT;
    if (task_get_state(mach_task_self(), ARM_DEBUG_STATE64, 
                       (thread_state_t)&state, &state_count) != KERN_SUCCESS) {
        pthread_rwlock_unlock(&ctx.rwlock);
        return false;
    }
    bool state_modified = false;
    for (int i = 0; i < count; i++) {
        uintptr_t target = (uintptr_t)old[i];
        for (int j = 0; j < ctx.active; j++) {
            if (ctx.targets[j].src == target) {
                int bp_idx = -1;
                for (int k = 0; k < 6; k++) {
                    if (state.__bvr[k] == target) {
                        bp_idx = k;
                        break;
                    }
                }
                if (bp_idx != -1) {
                    state.__bvr[bp_idx] = 0;
                    state.__bcr[bp_idx] = 0;
                    state_modified = true;
                }
                if (j < ctx.active - 1) {
                    memmove(&ctx.targets[j], &ctx.targets[j + 1], 
                            (ctx.active - j - 1) * sizeof(ctx.targets[0]));
                }
                ctx.active--;
                break;
            }
        }
    }
    if (state_modified) {
        qsort(ctx.targets, ctx.active, sizeof(ctx.targets[0]), compare_targets);
        if (task_set_state(mach_task_self(), ARM_DEBUG_STATE64, 
                           (thread_state_t)&state, ARM_DEBUG_STATE64_COUNT) != KERN_SUCCESS) {
            pthread_rwlock_unlock(&ctx.rwlock);
            return false;
        }
        apply_breakpoints_to_threads(&state);
    }
    pthread_rwlock_unlock(&ctx.rwlock);
    return true;
}

bool hook_one_point(void* instance, void* function) {
    void* o[] = { instance };
    void* n[] = { function };
    return hook(o, n, 1);
}

bool unhook_one_point(void* instance) {
    void* o[] = { instance };
    return unhook(o, 1);
}