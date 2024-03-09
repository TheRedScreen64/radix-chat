#include "String.h"

#include "../debug.h"

#include "../Vector.h"

#include <string.h>

char *xstrgetfileextension(char *str)
{
    assert_non_null(str);

    register char *str_start = str;

    for (; *str != '\00'; ++str)
        ;
    for (; str != str_start && *str != '.'; --str)
        ;

    return str;
}

int strend(char *str)
{
    assert_non_null(str);

    for (; *str != null; ++str)
        ;
    return *(str - 1);
}

int strendswith(char *str, char *end)
{
    assert_non_null(str);
    assert_non_null(end);

    for (char *bound = end; *str != null; ++str)
        if (*end == *str)
            ++end;
        else
            end = bound;
    return (*end == null);
}

int strstartswith(char *str, char *start)
{
    assert_non_null(str);
    assert_non_null(start);

    for (; *str == *start; ++str, ++start)
        if (*str == null)
            return 0;
    return (*start == '\00') ? 1 : 0;
}

int strequals(char *str1, char *str2)
{
    assert_non_null(str1);
    assert_non_null(str2);

    for (; *str1 == *str2; ++str1, ++str2)
        if (*str1 * *str2 == null)
            return *str2 == 0;
    return 0;
}

char *strsplitmutable(char *str, char split)
{
    assert_non_null(str);

    for (; *str != split; ++str)
        if (*str == '\00')
            return str;
    *str = '\00';
    return str + 1;
}

char *strreplaceall(char *str, char *_target, char *replace)
{
    XString res = xstrcreate();

    for (; *str != '\00'; str++)
    {
        register char *current = str;
        register char *target = _target;

        if (*current == *target)
            for (;; ++target, ++current)
            {
                if (*target == '\00') /* replace */
                {
                    xstrappends(&res, replace);
                    str = current;
                    break;
                }
                else if (*current != *target)
                    break;
            }
        xstrappend(res, *str);
    }
    return xstrserialize(res);
}

char *strreplaceallmultiple(char *str, ...)
{
    __builtin_va_list arguments;
    __builtin_va_start(arguments, str);

    Vector(char *) arguments_copy = vect_create(char *);

    register char *current_argument;
    while ((current_argument = __builtin_va_arg(arguments, char *)) != null)
        vect_pushback(arguments_copy, current_argument);

    XString res = xstrcreate();

    for (; *str != '\00'; str++)
    {
        //printf("%s\n", str);
        vect_foreach(arguments_copy, char *, cur)
        {
            register char *current = str;
            register char *target = *(cur++);

            if (*current == *target)
                for (;; ++target, ++current)
                {
                    if (*target == '\00') /* replace */
                    {
                        xstrappends(&res, *cur);
                        str = current;
                        goto cont;
                    }
                    else if (*current != *target)
                        goto next;
                }

        next:
            continue;
        }
    cont:
        xstrappend(res, *str);
        continue;
    }

    vect_free(arguments_copy);
    __builtin_va_end(arguments);

    return xstrserialize(res);
}

void strreplaceallmultipletd(XString* dest, char *str, ...)
{
    __builtin_va_list arguments;
    __builtin_va_start(arguments, str);

    Vector(char *) arguments_copy = vect_create(char *);

    register char *current_argument;
    while ((current_argument = __builtin_va_arg(arguments, char *)) != null)
        vect_pushback(arguments_copy, current_argument);

    for (; *str != '\00'; str++)
    {
        //printf("%s\n", str);
        vect_foreach(arguments_copy, char *, cur)
        {
            register char *current = str;
            register char *target = *(cur++);

            if (*current == *target)
                for (;; ++target, ++current)
                {
                    if (*target == '\00') /* replace */
                    {
                        xstrappends(dest, *cur);
                        str = current;
                        goto cont;
                    }
                    else if (*current != *target)
                        goto next;
                }

        next:
            continue;
        }
    cont:
        xstrappendc(dest, *str);
        continue;
    }

    vect_free(arguments_copy);
    __builtin_va_end(arguments);
}

void xstrreplaceonce(XString *_str, char *_target, int _target_len, char *replace, int replace_len)
{
    for (register char *str = _str->_str; *str != '\00'; str++)
    {
        register char *current = str;
        register char *target = _target;

        if (*current == *target)
            for (;; ++target, ++current)
            {
                if (*target == '\00') /* replace */
                {
                    register int size_difference = replace_len - _target_len; /* expand string if required */
                    while (malloc_usable_size(_str->_str) <= _str->_size + size_difference)
                        _str->_str = realloc(_str->_str, malloc_usable_size(_str->_str) * 2);

                    /* move part of thats string ahead of replaced part */
                    memmove(str + replace_len, str + _target_len, _str->_size - (current - _str->_str));
                    memcpy(str, replace, replace_len); /* replace part */
                    _str->_size += size_difference;
                    /* replace once -> return */
                    return;
                }
                else if (*current != *target)
                    break;
            }
    }
}

signed int strequalsmo(char *str, char opts, ...)
{
    assert_non_null(str);

    __builtin_va_list arguments;
    __builtin_va_start(arguments, opts);
    for (unsigned int i = 0; i < opts; ++i)
    {
        char *str1 = __builtin_va_arg(arguments, char *);
        char *str2 = str;
        for (; *str1 == *str2; ++str1, ++str2)
            if (*str1 == null)
                if (*str2 == 0)
                    return i;
                else
                    break;
            else if (*str2 == null)
                return i;
        continue;
    }
    __builtin_va_end(arguments);
    return -1;
}

unsigned long long strhash(char *str)
{
    assert_non_null(str);

    unsigned long long res = *str;
    for (int i = 0; *str != null; ++str, ++i)
        res = res + (*str * i * 1325222022ULL) >> 3;
    return res;
}

void xstrappends(XString *str, char *stra)
{
    assert_non_null(stra);

    for (; *stra != '\00'; ++stra)
    {
        if ((str->_size) == malloc_usable_size(str->_str))
            str->_str = realloc(str->_str, malloc_usable_size(str->_str) * 2);
        *(str->_str + (str->_size++)) = *stra;
    }
}

void xstrappendc(XString *str, char stra)
{
    assert_non_null(str);

    xstrappendToBuff(str, stra);
}

#include "Convert.h"

char *strcreaterandomlowercase(int lengtha, int lengthb)
{
    int length = lengtha + (rand() % (lengthb - lengtha));
    char *str = (char *)malloc(length + 2);
    for (*(str + length + 1) = '\00'; length > -1; --length)
        *(str + length) = 'a' + rand() % 26;
    return str;
}

char *strcreaterandom(int lengtha, int lengthb)
{
    int length = lengtha + (rand() % (lengthb - lengtha));
    char *str = (char *)malloc(length + 2);
    for (*(str + length + 1) = '\00'; length > -1; --length)
        *(str + length) = 1 + rand() % 254;
    return str;
}

int strcontainschar(char *str, char ch)
{
    assert_non_null(str);

    for (; *str != '\00'; str++)
        if (*str == ch)
            return 1;
    return 0;
}

/*
782908288
827879382
323282570
801035571
775334175
909725523
854288092
944487953*/

char *strremoveAdStart(char *str, char *start)
{
    assert_non_null(str);
    assert_non_null(start);

    // (~*start | ~*str) != -1 /* check if one of the strings is value 0 */
    for (; *str == *start; ++str, ++start)
        if (*str == null)
            return null;
    return (*start == '\00') ? str : null;
}

char *strremovecAdStart(char *str, char ch)
{
    assert_non_null(str);

    // (~*start | ~*str) != -1 /* check if one of the strings is value 0 */
    for (; *str == ch; ++str)
        ;
    return str;
}

char *strcopyusingmalloc(char *str)
{
    assert_non_null(str);

    XString copy = xstrcreate();
    for (; *str != null; ++str)
        xstrappend(copy, *str);
    return xstrserialize(copy);
}

char *strccat(char *str1, char *str2)
{
    assert_non_null(str1);
    assert_non_null(str2);

    xstrcreateft(con, str1);
    xstrappends(&con, str2);
    return xstrserialize(con);
}

char *strccatph(char *str1, char ph, char *str2)
{
    assert_non_null(str1);
    assert_non_null(str2);

    xstrcreateft(con, str1);
    xstrappend(con, ph);
    xstrappends(&con, str2);
    return xstrserialize(con);
}

char *strsubbf(char *str1, char *i)
{
    assert_non_null(str1);
    assert_non_null(i);

    XString con = xstrcreate();
    for (; *str1 != null; ++str1)
    {
        if (*str1 == *i && ({
                char *_ = i;
                for (char *__ = str1;
                     *__ == *_ && *__ != null && *_ != null;
                     ++__, ++_)
                    ;
                *_ == null;
            }))
            return xstrserialize(con);
        xstrappend(con, *str1);
    }
    return xstrserialize(con);
}

char *strsearch(char *str1, char *i)
{
    assert_non_null(str1);
    assert_non_null(i);

    for (; *str1 != null; ++str1)
    {
        if (*str1 == *i)
        {
            char *cmp1 = i;
            char *cmp2;
            for (cmp2 = str1;
                 *cmp2 == *cmp1 && *cmp2 != null && *cmp1 != null;
                 ++cmp2, ++cmp1)
                ;
            if (*cmp1 == null)
                return cmp2;
        }
    }
    return null;
}

char *strsearchbf(char *str1, char *i)
{
    assert_non_null(str1);
    assert_non_null(i);

    for (; *str1 != null; ++str1)
    {
        if (*str1 == *i)
        {
            char *cmp1 = i;
            char *cmp2;
            for (cmp2 = str1;
                 *cmp2 == *cmp1 && *cmp2 != null && *cmp1 != null;
                 ++cmp2, ++cmp1)
                ;
            if (*cmp1 == null)
                return str1;
        }
    }
    return null;
}