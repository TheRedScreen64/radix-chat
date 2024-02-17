#include "debug.h"

#ifdef UTIL_STD
debug void log_time(const char *str, ...)
{
    __builtin_va_list list;
    time_t current_time = time(null);
    char time_str[T_FORMAT_L];
    strftime((char *)&time_str, sizeof(time_str), T_FORMAT, localtime(&current_time));
    printf((char *)&time_str);
    __builtin_va_start(list, str);
    vprintf(str, list);
}

debug void log_timep(int p, const char *str, ...)
{
    __builtin_va_list list;
    time_t current_time = time(null);
    char time_str[T_FORMAT_L + p];
    strftime(((char *)&time_str + p), sizeof(char) * T_FORMAT_L, T_FORMAT, localtime(&current_time));

    for (int i = 0; i < p; ++i)
        time_str[i] = ' ';

    printf((char *)&time_str);
    __builtin_va_start(list, str);
    vprintf(str, list);
}
#endif

#ifdef UTIL_DEBUG_TIME

SHashmap utdt_objectives;
int dc;

void utdt_check(Pair *p)
{
    if (((struct timeinf *)p->value)->average._size > 0)  {
        log_time("\e[32mFinished\e[0m objective \e[37m\e[1m'%s'\e[0m after an average time of \e[1m%lF\e[0ms (Total: \e[1m%lF\e[0ms).\n", ((struct timeinf*)p->value)->name, vect_average( ((struct timeinf*)p->value)->average, double), vect_sum( ((struct timeinf*)p->value)->average, double));
        free(((struct timeinf*)p->value)->average._vect);
    }
    else
        log_time("\e[91mFailed\e[0m objective \e[37m\e[1m'%s'\e[0m\n", ((struct timeinf *)p->value)->name);
}

/* destructor */
__attribute__((section("._exit"))) void utdt_exit(int sig)
{
    if (dc++ != 0) /* check if deconstructor was already called*/
        return;
    shm_iterate(&utdt_objectives, utdt_check);
    _shm_delete_fbm(utdt_objectives, 0, 0);
}

/* constructor */
__attribute__((constructor, section("._init"))) void utdt_init()
{
    shm_createob(&utdt_objectives);
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wincompatible-pointer-types" /* will still work :D */

    atexit(utdt_exit); /* not needed since exit function doesn't work currently (look https://github.com/Swiftense/SwiftenseScript/blob/main/kernel_bug_v6.5.7-200.fc38.x86_64.tar.xz) */

#pragma GCC diagnostic pop
}

#endif