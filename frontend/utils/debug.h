/// @author Noah Nagel

#ifndef DEBUG_HF /* different header guard this time :) */
#define DEBUG_HF

#ifdef __cplusplus
extern "C"
{
#endif

#include "null.h"

#ifndef debug
#define debug __attribute__((cold))
#endif

/* general debug mode */
#ifdef UTIL_DEBUG_CMPL
#include "ansicodes.h"

/* assert functions */
#define ASSERT_FAILED_ERR(ASSERT_ID, name) "<" AC_RED  "error" AC_RESET "> assert " AC_BOLD #ASSERT_ID AC_RESET " in " AC_BOLD"%s" AC_RESET" failed (Variable: " AC_MAGENTA name AC_RESET ")\n", __func__
#define assert_str_not_empty(str) if(*str == '\00') { printf(ASSERT_FAILED_ERR(assert_str_not_empty, #str)); exit(1); }
#define assert_non_null(str) if(str == null) { printf(ASSERT_FAILED_ERR(assert_non_null, #str)); exit(1); }

/* logger functions */
#define UTIL_STD 1
/* used to log something */
#define debg(d) log_time(d)
/* used to log something and additional information */
#define debgaa(d, a1, a2) log_time(d, a1, a2)
#define debga(d, a) log_time(d, a)
#define debgap(p, d, a) log_timep(p, d, a)
/* used to print sth */
#define debgt(a) printf(a)
#else
/* assert functions */
#define assert_str_not_empty(str) ;
#define assert_non_null(ptr) ;


/* logger functions */
/* debug print with one param */
#define debg(d) ;
/* debug print with one argument plus one additional */
#define debga(d, a) ;
/* debug print with one argument plus two additional */
#define debgaa(d, a1, a2) ;
/* debug print with one argument plus one additional and padding <p> */
#define debgap(d, a, p) ;
/* standard print only in debug mode */
#define debgt(a) ;
#endif

/* time debug mode  */
#ifdef UTIL_DEBUG_TIME
#define UTIL_STD 1

#include <time.h>
#include "SHashmap.h"
#include <signal.h>

#include "Vector.h"

    struct timeinf
    {
        struct timespec start;
        struct timespec end;
        Vect_double average;
        const char *name;
    };

    extern SHashmap utdt_objectives;

#define timevar(obj) \
    struct timeinf obj##_dat;

#define timestart(obj)                                                      \
    shm_set(&utdt_objectives, #obj, &(obj##_dat));                          \
    (obj##_dat).name = #obj;                                                \
    if ((obj##_dat).average._vect == null)                                  \
        (obj##_dat).average._vect = malloc(sizeof(double*) * VECT_INIT_CAP); \
    clock_gettime(CLOCK_MONOTONIC, &(obj##_dat).start);

#define timepush(obj)                                 \
    clock_gettime(CLOCK_MONOTONIC, &(obj##_dat).end); \
    vect_pushback((obj##_dat).average, (double)((obj##_dat).end.tv_sec - (obj##_dat).start.tv_sec) + (double)((obj##_dat).end.tv_nsec - (obj##_dat).start.tv_nsec) / 1e9);

#else

#define timevar(obj) ;

#define timestart(obj) ;

#define timepush(obj) ;

#endif

#ifdef UTIL_STD
    ;

#define T_FORMAT "[%I:%M:%S] "
#define T_FORMAT_L sizeof(T_FORMAT)

    extern void log_time(const char *str, ...);
    extern void log_timep(int p, const char *str, ...);
#include <time.h>
#include <stdio.h>
#endif

#ifdef __cplusplus
}
#endif

#endif