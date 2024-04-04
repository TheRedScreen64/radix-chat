/// @author Noah Nagel

#ifndef NSTRING_UT
#define NSTRING_UT

#include "NMap.h"

/* copies string to map */
#define nstr_copytomap(str, map) ({                            \
    register _nmap_size cap = __NMAP_DEFAULT_PAGESIZE;         \
    register char *res = (char *)nmap_alloc(map, cap);         \
    register _nmap_size i = 0;                                 \
    for (; *str != '\00'; ++str, ++i)                          \
    {                                                          \
        if (i == cap)                                          \
            res = (char *)nmap_realloc(map, res, (cap <<= 1)); \
        *(res + i) = *str;                                     \
    }                                                          \
    *(res + i) = '\00';                                        \
    res;                                                       \
})

/* appends <str> to string on <map> bounded at <ptr> */
#define nstr_copytomapptr(addition_string, map, src_ptr) ({            \
    register _nmap_size cap = nmap_usableSize(src_ptr);                \
    register _nmap_size i = 0;                                         \
    for (; *(src_ptr + i) != '\00'; ++i)                               \
        ;                                                              \
    for (; *addition_string != '\00'; ++addition_string, ++i)          \
    {                                                                  \
        if (i == cap)                                                  \
            src_ptr = (char *)nmap_realloc(map, src_ptr, (cap <<= 1)); \
        *(src_ptr + i) = *addition_string;                             \
    }                                                                  \
    *(src_ptr + i) = '\00';                                            \
    src_ptr;                                                           \
})

#define nstr_copytomapptrs(map, src, src_size, addition, addition_size) ({ \
    register _nmap_size cap = nmap_usableSize(src);                        \
    for (_nmap_size i = src_size, j = 0; j < addition_size; ++i, j++)      \
    {                                                                      \
        if (i == cap)                                                      \
            src = (char *)nmap_realloc(map, src, (cap <<= 1));             \
        *(src + i) = *(addition + j);                                      \
    }                                                                      \
    src;                                                                   \
})

/* copies string of <size> to map */
#define nstr_copytomapws(str, size, map) ({             \
    register char *res = (char *)nmap_alloc(map, size); \
    for (_nmap_size i = 0; i < size; ++str, ++i)        \
        *(res + i) = *str;                              \
    res;                                                \
})

#endif