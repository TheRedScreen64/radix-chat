
/// Deprecated String implementation
/// use String/String.h instead
/// @author Noah Nagel

#ifndef SSTRING_H
#define SSTRING_H
#ifdef __cplusplus
extern "C"
{
#endif
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <fcntl.h>
/* posix only */
#include <unistd.h>
#include <sys/stat.h>

#include "null.h"
#include "Convert.h"

    typedef unsigned int sstr_size;
    typedef struct _sstring SString;
    struct _sstring
    {
        unsigned int s_size, s_capacity;
        char *s_str;
    };

/* allocate sstring struct on stack */
#define sstr_createeOnStack(name)                                 \
    SString *name = (SString *)__builtin_alloca(sizeof(SString)); \
    name->s_capacity = 8;                                         \
    name->s_size = 0;                                             \
    name->s_str = (char *)malloc(name->s_capacity);

/* allocate sstring struct on stack */
#define sstr_createsOnStack(name, str, size)                      \
    SString *name = (SString *)__builtin_alloca(sizeof(SString)); \
    name->s_capacity = size;                                      \
    name->s_size = size;                                          \
    name->s_str = (char *)malloc(size);                           \
    memcpy(name->s_str, str, size);

/* returns size of string */
#define sstr_getSize(str) str->s_size

/* checks if string contains any characters */
#define sstr_isEmpty(str) str->s_size == 0

    // create String from C string
    struct _sstring *sstr_createcs(char *str);
    // create String from C string
    struct _sstring *sstr_creates(char *str, unsigned int size);
    // create empty String
    struct _sstring *sstr_createe();
    // create string by files
    struct _sstring *sstr_createff(char *path);
    SString *sstr_clone(SString *str);
    /* converts <str> to cstr */
    char *sstr_serialize(SString *str);
    // appends char to string
    void sstr_appendc(SString *str, char ch);
    /* shrinks or extends <str> to <size> */
    void sstr_truncate(struct _sstring *str, sstr_size size);
    // appends C string to SString
    void sstr_appends(SString *base, char *str, unsigned int size);
    // appends C string without given size to SString, last char of str has to be \0
    // is way slower than sstr_appends(), only used for readability of code
    void sstr_appendcs(struct _sstring *base, char *str);
    // appends hexadecimal to string
    void sstr_appendh(struct _sstring *base, unsigned long long num);
    void sstr_appendformat(SString *str, char *format, ...);
    // appends decimal to string
    void sstr_appendd(struct _sstring *base, long long num);
    int sstr_equals(SString *base, char *str, unsigned int size);
    // checks for multiple equals at the same time
    signed int sstr_equals_mo(SString *base, char opts, ...);
    signed int sstr_cstr_equals_mo(char *str, unsigned char opts, ...);
    int sstr_endswith(SString *base, char *end, unsigned int end_size);
    int sstr_startswith(SString *base, char *start, unsigned int start_size);
    void sstr_delete(SString *str);
    // converts string to long, is relevant for search algorithms
    unsigned long long sstr_toLong(SString *str);
    int sstr_smaller(SString *str1, SString *str2);
    int sstr_bigger(SString *str1, SString *str2);
    static inline void sstr_removeAll(SString *str, char *replace, unsigned int size);
    // doesnt work bug free at the moment
    void sstr_replaceAll(SString *str, char *target, unsigned int tsize, char *replacement, unsigned int rsize);
    // clears section between a and b from string
    static inline void sstr_remove(SString *str, unsigned int a, unsigned int b);
    static inline void sstr_insert(SString *str, unsigned int pos, char *insert, unsigned int isize);
    // writes ssstring to file
    void sstr_write(SString *str, FILE *file);
    void printBits(size_t const size, void const *const ptr);
    void sstr_print(SString *str);
    // just like sstr_print without the \n at the end
    void sstr_printf(SString *str);
    void sstr_clear(SString *str);
    // appends char ch a certain amount to str
    void sstr_fill(SString *str, char ch, unsigned int amount);
    // starts parsing at end of <str>
    // removes everything after <target>
    void sstr_removeFromEndAfter(SString *str, char target);
    void sstr_removeFromEnd(SString *string, unsigned int amount);

#ifdef __cplusplus
}
#endif
#endif