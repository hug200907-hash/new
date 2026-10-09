#ifndef hook_h
#define hook_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>

bool hook(void *o[], void *n[], int c);
bool unhook(void *o[], int c);
bool hook_one_point(void *instance, void *function);
bool unhook_one_point(void *instance);
bool hook_reset(void *old[], void *n[], int count);
bool is_hooked(void *instance);
void *get_hook_target(void *instance);
bool hook_one_point_safe(void *instance, void *function);

#ifdef __cplusplus
}
#endif

#endif