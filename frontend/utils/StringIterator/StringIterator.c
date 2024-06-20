#include "StringIterator.h"

/* define integer constants */
#define DEC_CONST_UCHAR 0x18                  /* math.floor(2^8 / 10) - 1  */
#define DEC_CONST_USHORT 0x1998               /* math.floor(2^16 / 10) - 1 */
#define DEC_CONST_UINT 0x19999998             /* math.floor(2^32 / 10) - 1 */
#define DEC_CONST_ULONG 0x1999999999999998ULL /* math.floor(2^64 / 10) - 1 */

#define DEC_CONST_CHAR 0xB                  /* math.floor(2^7 / 10) - 1  */
#define DEC_CONST_SHORT 0xCCB               /* math.floor(2^15 / 10) - 1 */
#define DEC_CONST_INT 0xCCCCCCB             /* math.floor(2^31 / 10) - 1 */
#define DEC_CONST_LONG 0xCCCCCCCCCCCCCCBULL /* math.floor(2^63 / 10) - 1 */

#define DEC_CONST_INT_MAX_VAL 0x7FFFFFFF /* 2^31 - 1 */

#define SUFFIX_FLOAT 'f'
#define SUFFIX_DOUBLE 'F'

#define SUFFIX_LONG 'l'
#define SUFFIX_LONGLONG 'L'
#define SUFFIX_ULONG 'u'
#define SUFFIX_ULONGLONG 'U'

struct
{
    char *err;
    /* used to store the ptr of where the error was detected */
    char *err_source_end;
} INFO;

char *itr_geterr()
{
    return INFO.err;
}

enum
{
    ITR_CHAR_NONE = 0x0,
    ITR_CHAR_LINEBREAK = 0x1,
    ITR_CHAR_EMPTY = 0x2 /* spaces or tabs */,
    ITR_CHAR_DIGITORLETTER = 0x3, /* check for > ITR_DIGITORLETTER*/
    ITR_CHAR_DIGIT = 0x4,
    ITR_CHAR_LETTER = 0x5
} charTable[256];
#define itr_gettype(ch) charTable[ch]

#define __mapcapacity__ *(unsigned long long *)(itr + 1)

StringIterator *itr_loadFromLargeFile(char *file)
{
    assert_non_null(file);

    itr_construct();

    StringIterator *itr = (StringIterator *)malloc(sizeof(StringIterator) + sizeof(unsigned long long));
    int fd = open(file, O_RDWR, S_IRUSR | S_IWUSR);

    if (fd == -1)
    {
        perror("open");
        return null;
    }

    struct stat sb;
    fstat(fd, &sb);
    __mapcapacity__ = sb.st_size;

    itr->init = (char *)mmap(0, __mapcapacity__, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

    if (itr->init == null)
    {
        perror("mmap");
        return null;
    }

    itr->bound = itr->init;
    itr->line = 1;
    itr->str = itr->init;
    return itr;
}

__attribute__((ifunc("__itr_construct"))) void itr_construct();
void _itr_construct(){};
void *__itr_construct() /* only once called when firstly creating string iterator */
{
    /* setup char table */
    for (unsigned char i = 0; i < 255; ++i)
    {
        if (('0' <= i && i <= '9'))
            charTable[i] = ITR_CHAR_DIGIT;
        else if ((('a' <= i && i <= 'z') || ('A' <= i && i <= 'Z') || (i == '_')))
            charTable[i] = ITR_CHAR_LETTER;
        else if (i == ' ' || i == '\t')
            charTable[i] = ITR_CHAR_EMPTY;
        else if (i == '\n')
            charTable[i] = ITR_CHAR_LINEBREAK;
        else
            charTable[i] = ITR_CHAR_NONE;
    }

    /* initialize error info */
    INFO.err = "Success";
    INFO.err_source_end = "None";
    return &_itr_construct;
};

int itr_closeLargeFile(StringIterator *itr)
{
    assert_non_null(itr);

    munmap(itr->init, __mapcapacity__);
    free(itr);
}

#undef __mapcapacity__
unsigned int itr_getcolumn(StringIterator *iterator)
{
    assert_non_null(iterator);

    char *str = iterator->bound;
    unsigned int column = 1;
    for (; str != iterator->init && *(str - 1) != '\n'; ++column, --str)
        ;
    return column;
}

unsigned int itr_getline(StringIterator *iterator)
{
    assert_non_null(iterator);

    return iterator->line;
}

#define __str__ (iterator->str)
#define __line__ (iterator->line)

static inline void itr_skipcomments(struct _StringIterator *iterator)
{
    for (;; ++__str__)
    {
        switch (*__str__)
        {
        case ' ':
            break;
        case '\t':
            break;
        case '\n':
            ++__line__;
            break;
        case ';':
            if (*(__str__++ + 1) == ';')
            {
                for (; *__str__ != '\00'; ++__str__)
                    if (*__str__ == ';' && *(__str__ + 1) == ';')
                        break;
                    else if (*__str__ == '\n')
                    {
                        ++__line__;
                    }
            }
            else
            {
                for (++__line__; *__str__ != '\n' && *__str__ != '\00'; ++__str__)
                    ;
            }
            break;
        default:
            return;
        }
    }
}

char *itr_state(struct _StringIterator *iterator)
{
    assert_non_null(iterator);

    return iterator->str;
}

#define itrstr      \
    struct          \
    {               \
        char *_str; \
        int _size;  \
    }

#define itrstrcreate()                 \
    {                                  \
        ._str = malloc(24), ._size = 0 \
    }

#define itrstrappend(str, ch)                                               \
    {                                                                       \
        if ((str._size) == malloc_usable_size(str._str))                    \
            str._str = realloc(str._str, malloc_usable_size(str._str) * 2); \
        *(str._str + (str._size++)) = ch;                                   \
    }

#define itrstrappends(str, stra)   \
    for (; *stra != '\00'; ++stra) \
    itrstrappend(str, *stra)

#define itrstrgrow(str)                              \
    if ((str._size) == malloc_usable_size(str._str)) \
        str._str = realloc(str._str, malloc_usable_size(str._str) * 2);

#include "itr_getAbstract.h"

/* ignore unused result of realloc */
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-result"
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wattributes"

/* if an request doesn't match the state is being poped to the bound */
#define popandreturn(errmsg)                 \
    {                                        \
        INFO.err = errmsg;                   \
        INFO.err_source_end = iterator->str; \
        iterator->str = iterator->bound;     \
        return ITR_NO_MATCH;                 \
    }

void _itr_skipchars(StringIterator *iterator)
{
skip:
    switch (*__str__)
    {
    case '\n':
        ++__line__, ++__str__;
        goto skip;
    case ' ':
    case '\t':
        ++__str__;
        goto skip;
    default:
        return;
    }
}
#pragma GCC diagnostic pop

/* if an request matches the bound is being pushed to iterator->str*/
#define pushandreturn(_json_)            \
    {                                    \
        iterator->bound = iterator->str; \
        return _json_;                   \
    }

#include "Serialize.h"

JsonObject *_itr_collectJsonMap(StringIterator *iterator)
{
    assert_non_null(iterator);

    if (itr_char(iterator, '{') == ITR_NO_MATCH)
        popandreturn("invalid Json Object");

    register char *key;

    JsonObject *obj = shm_create();

    if (itr_char(iterator, '}') == ITR_MATCH)
        return obj;

    AbstractValue *value;
collect_entry_4:
    value = (AbstractValue *)malloc(sizeof(AbstractValue));
    {
        /* get key */
        if ((key = itr_getstr(iterator)) == ITR_NO_MATCH)
            popandreturn("invalid Json Value");
        if (itr_char(iterator, ':') == ITR_NO_MATCH)
            popandreturn("missing Json Value");

        /* get value */
        itr_getAbstract(iterator, value);
        switch (value->valueType)
        {
        case IT_NONE:
            popandreturn("invalid Json Entry");
        case IT_TEXT:
            switch (strequalsmo(value->valueData.string_val, 3, "true", "false", "null"))
            {
            case 1:
                value->valueType = IT_NOSTD_TRUE;
                free(value->valueData.string_val);
                break;
            case 2:
                value->valueType = IT_NOSTD_FALSE;
                free(value->valueData.string_val);
                break;
            case 3:
                value->valueType = IT_NOSTD_NULL;
                free(value->valueData.string_val);
                break;
            default:
                value->valueType = IT_STRING; /* update type and ignore violation of JSON Standard */
                break;
            }
            break;
        default:
            break;
        }

        shm_set(obj, key, value);

        if (itr_char(iterator, ',') == ITR_MATCH)
            goto collect_entry_4;
        if (itr_char(iterator, '}') == ITR_MATCH)
            pushandreturn(obj);
        popandreturn("missing object terminator '}'");
    }
}

#include "../debug.h"

JsonArray *_itr_collectJsonList(StringIterator *iterator)
{
    assert_non_null(iterator);

    if (itr_char(iterator, '[') == ITR_NO_MATCH)
        popandreturn("invalid Json Array");

    AbstractValue value;

    JsonArray *arr = malloc(sizeof(JsonArray));
    vect_initializeBuff(arr, AbstractValue);

    if (itr_char(iterator, ']') == ITR_MATCH)
        return arr;

collect_entry:
{
    /* get value/entry */
    itr_getAbstract(iterator, &value);
    switch (value.valueType)
    {
    case IT_NONE:
        popandreturn("invalid Json Entry");
    case IT_TEXT:
        switch (strequalsmo(value.valueData.string_val, 3, "true", "false", "null"))
        {
        case 1:
            value.valueType = IT_NOSTD_TRUE;
            free(value.valueData.string_val);
            break;
        case 2:
            value.valueType = IT_NOSTD_FALSE;
            free(value.valueData.string_val);
            break;
        case 3:
            value.valueType = IT_NOSTD_NULL;
            free(value.valueData.string_val);
            break;
        default:
            value.valueType = IT_STRING; /* update type and ignore violation of JSON Standard */
            break;
        }
        break;
    default:
        /* value can be saved as it is */
        break;
    }

    vect_pushbackBuff(arr, value);

    if (itr_char(iterator, ',') == ITR_MATCH)
        goto collect_entry;
    if (itr_char(iterator, ']') == ITR_MATCH)
        pushandreturn(arr);

    popandreturn("missing array terminator ']'");
}
}

#undef pushandreturn

/* if an request matches the bound is being pushed to iterator->str*/
#define pushandreturn(_str_)             \
    {                                    \
        iterator->bound = iterator->str; \
        itrstrappend(_str_, '\00');      \
        return _str_._str;               \
    }

char *itr_getlinestr(StringIterator *iterator)
{
    assert_non_null(iterator);

    char *str = iterator->bound;
    for (; str != iterator->init && *(str - 1) != '\n'; --str)
        ;
    itrstr line = itrstrcreate();
    for (; *str != '\n' && *str != '\00'; ++str)
        itrstrappend(line, *str);
    itrstrappend(line, '\00');
    return line._str;
}

char *_itr_gettext(struct _StringIterator *iterator)
{
    assert_non_null(iterator);

    /* check if string is valid */
    if (itr_gettype(*__str__) != ITR_CHAR_LETTER) /* cannot start with a number */
        popandreturn("invalid literal");
    /* copy string to new str buff */
    itrstr str = itrstrcreate();
    for (; itr_gettype(*__str__) > ITR_CHAR_DIGITORLETTER /* letters, underscores, digits */; ++__str__)
    {
        if (*__str__ == null)
            pushandreturn(str); /* doesn't need an enclosure */
        itrstrappend(str, *__str__);
    }
    pushandreturn(str);
}

char *_itr_getstr(struct _StringIterator *iterator)
{
    assert_non_null(iterator);

    /* check if string is valid */
    if (*(__str__++) != '"')
        popandreturn("invalid string");
    /* copy string to new str buff */
    itrstr str = itrstrcreate();
    for (;;)
    {
        switch (*__str__)
        {
        case '\000':
            popandreturn("expected string enclosure (\")");
        case '"':
            __str__++;
            pushandreturn(str);
        case '\n':
            popandreturn("illegal linebreak");
        case '\\':
            if (*((__str__++) + 1) == '\\')
            {
                ++__str__;
                itrstrappend(str, '\\');
                break;
            };
            itrstrgrow(str);
            if (!_itr_getuveryshort(iterator, (str._str + (str._size++))))
            {
                popandreturn("invalid character format code");
            }
            break;
        default:
            itrstrappend(str, *__str__);
            ++__str__;
        }
    }
}

#pragma GCC diagnostic pop

#undef itrstr
#undef itrstrcreate
#undef itrstrappend
#undef pushandreturn

#define pushandreturn()                  \
    {                                    \
        iterator->bound = iterator->str; \
        return ITR_MATCH;                \
    }

int _itr_getchar(struct _StringIterator *iterator, char *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    if (*(__str__++) != '\'')
        popandreturn("invalid character");

    switch ((*itr_buff = *(__str__++)))
    {
    case '\n':
        popandreturn("illegal linebreak");
    case '\000':
        popandreturn("expected character");
        break;
    case '\\':
        if (*((__str__++) + 1) == '\\')
        {
            ++__str__;
            *itr_buff = '\\';
            break;
        };
        if (!_itr_getuveryshort(iterator, itr_buff))
        {
            popandreturn("invalid character format code");
        }
        break;
    default:
        break;
    }
    if (*(__str__++) != '\'')
        popandreturn("expected enclosure (')");
}

int _itr_getveryshort(struct _StringIterator *iterator, signed char *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if short is negative */
    char signed n = 1;
    if (*__str__ == '-')
        n = -1, ++__str__;
    register signed char s = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not an valid numer"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (s > DEC_CONST_CHAR)
            popandreturn("very short constant too large");
        s = s * 10 + *__str__ - '0';
    }
    *itr_buff = s * n;
    pushandreturn();
}

int _itr_getabstractnum(struct _StringIterator *iterator, AbstractValue *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    register long long n = 1;
    register long long l = 0;

    if (*__str__ == '-')
        n = -1, ++__str__;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    /* parse integer before point */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (l > DEC_CONST_LONG)
            popandreturn("long constant too large");
        l = l * 10 + *__str__ - '0';
        /* check for '_' if long is seperated like 1_234_567L */
        if (*(__str__ + 1) == '_')
            __str__++;
    }
    switch (*__str__)
    {
    case '.':
        __str__++; /* continue to parse integer after point */
        break;
    case SUFFIX_DOUBLE:
        __str__++;
        l = __builtin_copysignq(l, n);
        itr_buff->valueData.double_val = (double)l;
        itr_buff->valueType = IT_DOUBLE;
        pushandreturn();
    case SUFFIX_FLOAT:
        __str__++;
        l = __builtin_copysignq(l, n);
        itr_buff->valueData.double_val = (double)l;
        itr_buff->valueType = IT_FLOAT;
        pushandreturn();
    case SUFFIX_LONG:
    case SUFFIX_LONGLONG:
        __str__++;
        l = __builtin_copysignq(l, n);
        itr_buff->valueData.slong_val = (signed long long)l;
        itr_buff->valueType = IT_LONG;
        pushandreturn();
    case SUFFIX_ULONG:
    case SUFFIX_ULONGLONG:
        __str__++;
        itr_buff->valueData.ulong_val = (unsigned long long)l;
        itr_buff->valueType = IT_ULONG;
        pushandreturn();
    default: /* int */
        if (l > DEC_CONST_INT_MAX_VAL)
            popandreturn("integer constant too large")
                l = __builtin_copysignq(l, n);
        itr_buff->valueData.sint_val = (signed int)l;
        itr_buff->valueType = IT_INT;
        pushandreturn();
    }
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid double"); /* if not -> return 0 */
    /* parse integer after point */
    register double a = 1, b = 0;
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
        b = b * 10 + *__str__ - '0', a *= 10;
    if (*__str__ == SUFFIX_FLOAT || *__str__ == SUFFIX_DOUBLE) /* check for suffix */
        ++__str__;
    itr_buff->valueType = IT_DOUBLE;
    itr_buff->valueData.double_val = __builtin_copysignq((((double)l) /* integer before point */ + (b / a) /* integer after point */), n);
    pushandreturn();
}

int _itr_getshort(struct _StringIterator *iterator, signed short *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if short is negative */
    signed short n = 1;
    if (*__str__ == '-')
        n = -1, ++__str__;
    register signed short s = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not an valid numer"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (s > DEC_CONST_SHORT)
            popandreturn("short constant too large");
        s = s * 10 + *__str__ - '0';
    }
    *itr_buff = s * n;
    pushandreturn();
}

int _itr_getint(struct _StringIterator *iterator, signed int *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if int is negative */
    signed int n = 1;
    if (*__str__ == '-')
        n = -1, ++__str__;
    register signed int i = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (i > DEC_CONST_INT)
            popandreturn("integer constant too large");
        i = i * 10 + *__str__ - '0';
    }
    *itr_buff = i * n;
    pushandreturn();
}

int _itr_getlong(struct _StringIterator *iterator, signed long long *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if long is negative */
    signed long long n = 1;
    if (*__str__ == '-')
        n = -1, ++__str__;
    register signed long long l = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (l > DEC_CONST_LONG)
            popandreturn("long constant too large");
        l = l * 10 + *__str__ - '0';
        /* check for '_' if long is seperated like 1_234_567L */
        if (*(__str__ + 1) == '_')
            __str__++;
    }
    /* check for suffix */
    if (*__str__ != 'l' && *__str__ != 'L')
        popandreturn("missing suffix for 64 Bit integers ('L')");
    *itr_buff = l * n;
    pushandreturn();
}

int _itr_getuveryshort(struct _StringIterator *iterator, unsigned char *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if short is negative */
    if (*__str__ == '-')
        popandreturn("unsigned type has a sign");
    register unsigned char s = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (s > DEC_CONST_UCHAR)
            popandreturn("unsigned very short constant too large");
        s = s * 10 + *__str__ - '0';
    }
    *itr_buff = s;
    pushandreturn();
}

int _itr_getushort(struct _StringIterator *iterator, unsigned short *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if short is negative */
    if (*__str__ == '-')
        popandreturn("unsigned type has a sign");
    register unsigned short s = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (s > DEC_CONST_USHORT)
            popandreturn("unsigned short constant too large");
        s = s * 10 + *__str__ - '0';
    }
    *itr_buff = s;
    pushandreturn();
}

int _itr_getuint(struct _StringIterator *iterator, unsigned int *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if int is negative */
    if (*__str__ == '-')
        popandreturn("unsigned type has a sign");
    register unsigned int i = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (i > DEC_CONST_UINT)
            popandreturn("unsigned integer constant too large");
        i = i * 10 + *__str__ - '0';
    }
    *itr_buff = i;
    pushandreturn();
}

int _itr_getulong(struct _StringIterator *iterator, unsigned long long *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if long is negative */
    if (*__str__ == '-')
        popandreturn("unsigned type has a sign");
    register unsigned long long l = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
    {
        if (l > DEC_CONST_ULONG)
            popandreturn("unsigned long constant too large");
        l = l * 10 + *__str__ - '0';
        if (*(__str__ + 1) == '_')
            __str__++;
    }
    /* check for suffix */
    if (*__str__ != 'u' && *__str__ != 'U')
        popandreturn("missing suffix for unsigned 64 Bit integers ('U')");
    *itr_buff = l, __str__++;
    pushandreturn();
}

// jmp_buf getdouble;
//__attribute__((__returns_twice__))
int _itr_getdouble(struct _StringIterator *iterator, double *itr_buff)
{
    assert_non_null(iterator);
    assert_non_null(itr_buff);

    /* check if double is negative */
    double n = 1;
    if (*__str__ == '-')
        n = -1, ++__str__;
    register double d = 0;
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid number"); /* if not -> return 0 */
    /* parse integer before point */
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
        d = d * 10 + *__str__ - '0';
    if (*(__str__++) != '.')
        if (*(__str__ - 1) == SUFFIX_DOUBLE || *(__str__ - 1) == SUFFIX_FLOAT)
        {
            *itr_buff = __builtin_copysignq(d, n);
            pushandreturn();
        }
        else
            popandreturn("missing suffix for doubles ('D')");
    /* check if string contains valid decimal characters */
    if (itr_gettype(*__str__) != ITR_CHAR_DIGIT)
        popandreturn("not a valid double"); /* if not -> return 0 */
    /* parse integer after point */
    register double a = 1, b = 0;
    for (; itr_gettype(*__str__) == ITR_CHAR_DIGIT; ++__str__)
        b = b * 10 + *__str__ - '0', a *= 10;
    if (*__str__ == SUFFIX_FLOAT || *__str__ == SUFFIX_DOUBLE) /* check for suffix */
        ++__str__;
    *itr_buff = __builtin_copysignq((d /* integer before point */ + (b / a) /* integer after point */), n);
    pushandreturn();
}

#undef popandreturn
#undef pushandreturn

/* undef integer constants */
#undef DEC_CONST_UCHAR
#undef DEC_CONST_USHORT
#undef DEC_CONST_UINT
#undef DEC_CONST_ULONG

#undef DEC_CONST_CHAR
#undef DEC_CONST_SHORT
#undef DEC_CONST_INT
#undef DEC_CONST_LONG

//__attribute__((__noinline__))
// jmp_buf*_itr_getdoublebuf()
//{
//    longjmp(getdouble, 1);
//}

int itr_matchtext(struct _StringIterator *iterator, unsigned int options, ...)
{
    assert_non_null(iterator);

    itr_skipcomments(iterator);
    __builtin_va_list arguments;
    __builtin_va_start(arguments, options);
    iterator->bound = iterator->str;
    for (unsigned int i = 0; i < options; ++i)
    {
        char *text = __builtin_va_arg(arguments, char *);
        __str__ = iterator->bound;
        for (; *text != null; ++text, ++__str__)
            if (*__str__ != *text)
                goto _continue;
            else if (*__str__ == null)
                goto _continue;
        __builtin_va_end(arguments);
        iterator->bound = __str__;
        return i;
    _continue:
        __builtin_va_arg(arguments, void *);
        continue;
    }
    __builtin_va_end(arguments);
    __str__ = iterator->bound;
    return -1;
}

/// @author Noah Nagel
/// @deprecated Function
__attribute__((__deprecated__)) void itr_text(struct _StringIterator *iterator, void *itr_nomatch, unsigned int options, ...)
{
    assert_non_null(iterator);
    assert_non_null(itr_nomatch);

    itr_skipcomments(iterator);
    __builtin_va_list arguments;
    __builtin_va_start(arguments, options);
    iterator->bound = iterator->str;
    for (unsigned int i = 0; i < options; ++i)
    {
        char *text = __builtin_va_arg(arguments, char *);
        __str__ = iterator->bound;
        for (; *text != null; ++text, ++__str__)
            if (*__str__ != *text)
                goto _continue;
            else if (*__str__ == null)
                goto _continue;
        __builtin_va_end(arguments);
        iterator->bound = __str__;
        ((void (*)()) __builtin_va_arg(arguments, void *))();
        return;
    _continue:
        __builtin_va_arg(arguments, void *);
        continue;
    }
    __builtin_va_end(arguments);
    ((void (*)())itr_nomatch)();
    __str__ = iterator->bound;
    return;
}

/// @author Noah Nagel
/// @deprecated Function
__attribute__((__deprecated__)) void *itr_jtext(struct _StringIterator *iterator, void *itr_nomatch, unsigned int options, ...)
{
    assert_non_null(iterator);
    assert_non_null(itr_nomatch);

    /* skip useless characters */
    itr_skipcomments(iterator);
    __builtin_va_list arguments;
    __builtin_va_start(arguments, options);
    iterator->bound = __str__;
    for (unsigned int i = 0; i < options; ++i)
    {
        char *text = __builtin_va_arg(arguments, char *);
        __str__ = iterator->bound;
        for (; *text != null; ++text, ++__str__)
            if (*__str__ != *text)
                goto _continue;
            else if (*__str__ == null)
                goto _continue;
        __builtin_va_end(arguments);
        //__str__--;
        iterator->bound = __str__;
        return __builtin_va_arg(arguments, void *);
    _continue:
        __builtin_va_arg(arguments, void *);
        continue;
    }
    __builtin_va_end(arguments);
    __str__ = iterator->bound;
    return itr_nomatch;
}

int itr_char(StringIterator *iterator, char ch)
{
    assert_non_null(iterator);

    _itr_skipchars(iterator);
    if (*__str__ == ch)
    {
        ++__str__;
        return ITR_MATCH;
    }
    else
    {
        return ITR_NO_MATCH;
    }
}

int itr_search(StringIterator *iterator, char *section)
{
    assert_non_null(iterator);
    assert_non_null(section);

    if ((iterator->str = strsearch(iterator->str, section)) == null)
    {
        iterator->str = iterator->bound;
        return ITR_NO_MATCH;
    }
    iterator->bound = iterator->str;
    return ITR_MATCH;
}

int itr_searchbf(StringIterator *iterator, char *section)
{
    assert_non_null(iterator);
    assert_non_null(section);

    if ((iterator->str = strsearchbf(iterator->str, section)) == null)
    {
        iterator->str = iterator->bound;
        return ITR_NO_MATCH;
    }
    iterator->bound = iterator->str;
    return ITR_MATCH;
}

#undef __str__