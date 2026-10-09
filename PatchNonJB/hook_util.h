#ifndef HOOK_UTIL_H
#define HOOK_UTIL_H

#include <stdint.h> 
#include "Obfuscate.h"

#define UnityFramework ENCRYPT("Frameworks/UnityFramework.framework/UnityFramework")
#define HOOK(offset, ptr, orig) *(void **) (&orig) = (void*) hookOffset(offset, (void *) ptr);

inline void* hookOffset(uint64_t offset, void* replace) {
    return HookOffset(UnityFramework, offset, replace);
}

#endif // HOOK_UTIL_H
