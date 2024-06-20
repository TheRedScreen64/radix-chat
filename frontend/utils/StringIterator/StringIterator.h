/// @author Noah Nagel

#ifndef STRING_ITERATOR_H
#define STRING_ITERATOR_H

#ifdef __cplusplus
extern "C"
{
#endif
#include <malloc.h>
#include <stdlib.h>
#include <stdio.h>

#include <unistd.h>

#include <sys/stat.h>
#include <sys/types.h>
#include <sys/mman.h>

#include <fcntl.h>

#include "../String/String.h"
#include "../null.h"

#include "../SHashmap.h"
#include "../Vector.h"

#include "../label.h"

    struct _StringIterator
    {
        char *init;

        char *bound;
        char *str;
        unsigned int line;
    };

    typedef struct _StringIterator StringIterator;
    typedef SHashmap JsonObject;
    typedef struct _abstractValT AbstractValue;
    typedef Vector(AbstractValue) JsonArray;
    typedef AbstractValue JsonValue;

#define ITR_MATCH 0x1
#define ITR_NO_MATCH 0x0

    struct _abstractValT
    {
        enum
        {
            /* No Type Found*/
            IT_NONE = ITR_NO_MATCH,
            /* character */
            IT_CHAR = 0x1,
            /* 8 Bit Integers */
            IT_VERYSHORT = 0x2,
            IT_UVERYSHORT = 0x3,
            /* 16 Bit Integers */
            IT_SHORT = 0x4,
            IT_USHORT = 0x5,
            /* 32 Bit Integers */
            IT_INT = 0x6,
            IT_UINT = 0x7,
            /* 64 Bit Integers */
            IT_LONG = 0x8,
            IT_ULONG = 0x9,
            /* JSON Data*/
            IT_JSON = 0xa,
            IT_JSON_ARRAY = 0xb,
            IT_EMPTY = 0xc, /* spaces or linebreaks */

            /* non standard types only added for json compatability */
            IT_NOSTD_NULL = 0xd,
            IT_NOSTD_TRUE = 0xf,
            IT_NOSTD_FALSE = 0x10,

            /* floating point types < -33 */
            IT_FLOAT = -0x22,
            IT_DOUBLE = -0x23,

            /* litteral types > 33 */
            IT_STRING = 0x22, /* string, for instance: "bamboo" */
            IT_TEXT = 0x23    /* text, for instance: bamboo */
        } valueType;

        union
        {
            char char_val;
            signed char schar_val;
            unsigned char uchar_val;

            signed short sshort_val;
            unsigned short ushort_val;

            signed int sint_val;
            unsigned int uint_val;

            int bool_val;

            signed long long slong_val;
            unsigned long long ulong_val;

            float float_val;
            double double_val;

            char *string_val; /* string allocated using malloc */

            JsonObject *json_val;
            JsonArray *json_arr_val;

            void *uni_val;
        } valueData;
    };

#define itr_gettext(iterator) ({_itr_skipchars(iterator); _itr_gettext(iterator); })
#define itr_getstr(iterator) ({_itr_skipchars(iterator); _itr_getstr(iterator); })
#define itr_getchar(iterator, buff) ({_itr_skipchars(iterator); _itr_getchar(iterator, buff); })
#define itr_getveryshort(iterator, buff) ({_itr_skipchars(iterator); _itr_getveryshort(iterator, buff); })
#define itr_getabstractnum(iterator, buff) ({_itr_skipchars(iterator); _itr_getabstractnum(iterator, buff); })
#define itr_getshort(iterator, buff) ({_itr_skipchars(iterator); _itr_getshort(iterator, buff); })
#define itr_getint(iterator, buff) ({_itr_skipchars(iterator); _itr_getint(iterator, buff); })
#define itr_getlong(iterator, buff) ({_itr_skipchars(iterator); _itr_getlong(iterator, buff); })
#define itr_getuveryshort(iterator, buff) ({_itr_skipchars(iterator); _itr_getuveryshort(iterator, buff); })
#define itr_getushort(iterator, buff) ({_itr_skipchars(iterator); _itr_getushort(iterator, buff); })
#define itr_getuint(iterator, buff) ({_itr_skipchars(iterator); _itr_getuint(iterator, buff); })
#define itr_getulong(iterator, buff) ({_itr_skipchars(iterator); _itr_getulong(iterator, buff); })
#define itr_getdouble(iterator, buff) ({_itr_skipchars(iterator); _itr_getdouble(iterator, buff); })

#define itr_create(_str)                                                           \
    (struct _StringIterator){.bound = _str, .str = _str, .line = 1, .init = _str}; \
    itr_construct();

    extern StringIterator *itr_loadFromLargeFile(char *file);
    extern void itr_construct();
    /* returns current column of <iterator> */
    extern unsigned int itr_getcolumn(StringIterator *iterator);
    /* returns current line of <iterator> */
    extern unsigned int itr_getline(StringIterator *iterator);
    /* returns the text of the current line of <iterator> */
    extern char *itr_getlinestr(StringIterator *iterator);

    extern void itr_getAbstract(StringIterator *iterator, AbstractValue *value);
    extern void itr_clearAbstract(AbstractValue *value);
    extern void _itr_skipchars(StringIterator *iterator);

    extern void itr_printObject(AbstractValue *obj);
    /* automatically frees <obj> */
    extern void itr_stringify(AbstractValue *obj, XString *str);
    extern void itr_stringifyArray(JsonArray *arr, XString *str);
    extern void itr_stringifyObject(JsonObject *obj, XString *str);
    /* automatically frees dumped data <val> */
    extern void itr_dump(AbstractValue *val, const char *file);

    /* returns string pointer where the iterator currently is at */
    extern char *itr_state(struct _StringIterator *iterator);
    /* returns a string if the text was successfully parsed */
    extern char *_itr_gettext(struct _StringIterator *iterator);
    /* returns a string if the string was successfully parsed */
    extern char *_itr_getstr(struct _StringIterator *iterator);
    /* returns a string if the string was successfully parsed */
    extern int _itr_getchar(struct _StringIterator *iterator, char *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getveryshort(struct _StringIterator *iterator, signed char *itr_buff);
    /* returns ITR_MATCH if the number was successfully parsed */
    extern int _itr_getabstractnum(struct _StringIterator *iterator, AbstractValue *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getshort(struct _StringIterator *iterator, signed short *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getint(struct _StringIterator *iterator, signed int *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getlong(struct _StringIterator *iterator, signed long long *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getuveryshort(struct _StringIterator *iterator, unsigned char *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getushort(struct _StringIterator *iterator, unsigned short *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getuint(struct _StringIterator *iterator, unsigned int *itr_buff);
    /* returns ITR_MATCH if the integer was successfully parsed */
    extern int _itr_getulong(struct _StringIterator *iterator, unsigned long long *itr_buff);
    /* returns the error message */
    extern char *itr_geterr();
    /* returns ITR_MATCH if the double was successfully parsed */
    extern int _itr_getdouble(struct _StringIterator *iterator, double *itr_buff);

    extern JsonObject *_itr_collectJsonMap(StringIterator *itr);
    extern JsonArray *_itr_collectJsonList(StringIterator *itr);

    /* returns ITR_MATCH if <ch> matches the next relevant char of the iterated string */
    extern int itr_char(StringIterator *iterator, char ch);
    /* returns -1 if the text doesn't match any of the options or the index of the corresponding option */
    extern int itr_matchtext(struct _StringIterator *iterator, unsigned int options, ...);
    /* calls the function for the matching function */
    /// @author Noah Nagel
    /// @deprecated Function
    __attribute__((__deprecated__)) extern void itr_text(struct _StringIterator *iterator, void *itr_nomatch, unsigned int options, ...);
    /* returns the matching lable address */
    /// @author Noah Nagel
    /// @deprecated Function
    __attribute__((__deprecated__)) extern void *itr_jtext(struct _StringIterator *iterator, void *itr_nomatch, unsigned int options, ...);
    /* searches for a character sequence <section> in not yet iterated text */
    extern int itr_search(StringIterator *iterator, char *section);
    /* searches for a character sequence <section> in not yet iterated text */
    extern int itr_searchbf(StringIterator *iterator, char *section);
    extern int itr_closeLargeFile(StringIterator *itr);

#ifdef __cplusplus
}
#endif
#endif