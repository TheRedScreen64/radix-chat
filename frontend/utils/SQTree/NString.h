/// @author Noah Nagel

#ifndef NSTRING_UT
#define NSTRING_UT

#include "NMap.h"

timevar(copystr1)

/* copies string to map */
#define nstr_copytomap(str, map) ({                         \
    register _nmap_size cap = __NMAP_DEFAULT_PAGESIZE;      \
    register char *res = (char *)nmap_alloc(map, cap);      \
    for (_nmap_size i = 0; *str != '\00'; ++str, ++i)       \
    {                                                       \
        if (i == cap)                                       \
            res = (char *)nmap_seek(map, res, (cap <<= 1)); \
        *(res + i) = *str;                                  \
    }                                                       \
    res;                                                    \
})

/* copies string of <size> to map */
#define nstr_copytomapws(str, size, map) ({             \
    register char *res = (char *)nmap_alloc(map, size); \
    for (_nmap_size i = 0; i < size; ++str, ++i)        \
        *(res + i) = *str;                              \
    res;                                                \
})

#endif