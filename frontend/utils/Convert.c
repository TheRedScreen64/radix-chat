

#include "Convert.h"

#include "debug.h"

/* the amount of digits of original floating point that should be used in converted String */
/* the amount of zeros representate the amount of digits that are put into the new string after converting the floating point*/
#define FLOAT_CONVERSION_CONSTANT 100
#define DOUBLE_CONVERSION_CONSTANT 10000

/* max amount of characters in specific number type */
#define MAX_LENGTH_INT 12
#define MAX_LENGTH_LONG 21
#define MAX_LENGTH_UINT 11
#define MAX_LENGTH_ULONG 20
#define MAX_LENGTH_FLOAT MAX_LENGTH_LONG /* significant */ + MAX_LENGTH_ULONG /* fractional */ + 1 /*. symbol*/
                                                                                                   /* = 42 */

/* macro that extends temporary string */
/* equivalent to strcat(...) */
#define extend_string(p, val) \
    {                         \
        *p = val;             \
        ++p;                  \
    }

/* return type by numberType */
int convert_getType(char *cstr)
{
    assert_non_null(cstr);

    int type = NT_INT;
    if (*cstr == '-')
        ++cstr;
    int i;
    for (i = 0; *cstr != null; ++i, ++cstr)
    {
        switch (*cstr)
        {
        case '0':
        case '1':
        case '2':
        case '3':
        case '4':
        case '5':
        case '6':
        case '7':
        case '8':
        case '9':
            continue;
        case '.':
            return NT_FLOAT;
        default:
            return NT_NONE;
        }
    }
    if (type == NT_INT && i > MAX_LENGTH_UINT)
        return NT_LONG;
    return NT_INT;
}

int convert_LongToCStr(long long l, char *dest)
{
    assert_non_null(dest);

    char *b = (char *)__builtin_alloca(MAX_LENGTH_INT);
    char *a = b;
    char n;

    /* check for special cases */
    if (l < 0) /* number negative */
    {
        n = 1;
        l *= -1; /* make number positive */
    }
    else if (l == 0) /* number is 0 */
    {
        *dest = '0';
        return 1;
    }

    for (; l != 0; l /= 10)
        extend_string(b, l % 10 + '0');

    if (n)
        extend_string(b, '-')

            int size = b - a;
    /* reverse copy converted int to final string */
    for (--b; b >= a; --b, dest++)
        *dest = *b;

    return size;
}

int convert_ULongToCStr(unsigned long long l, char *dest)
{
    assert_non_null(dest);

    char *b = (char *)__builtin_alloca(MAX_LENGTH_UINT);
    char *a = b;

    if (l == 0)
    {
        *dest = '0';
        return 1;
    }

    for (; l != 0; l /= 10)
        extend_string(b, l % 10 + '0');

    int size = b - a;
    /* reverse copy converted int to final string */
    for (--b; b >= a; --b, dest++)
        *dest = *b;

    return size;
}

int convert_IntToCStr(int i, char *dest)
{
    assert_non_null(dest);

    char *b = (char *)__builtin_alloca(MAX_LENGTH_INT);
    char *a = b;
    char n = 0;

    /* check for special cases */
    if (i < 0) /* number negative */
    {
        n = 1;
        i *= -1; /* make number positive */
    }
    else if (i == 0) /* number is 0 */
    {
        *dest = '0';
        return 1;
    }

    for (; i != 0; i /= 10)
        extend_string(b, i % 10 + '0');

    if (n)
        extend_string(b, '-')

            int size = b - a;
    /* reverse copy converted int to final string */
    for (--b; b >= a; --b, dest++)
        *dest = *b;

    return size;
}

int convert_UIntToCStr(unsigned int i, char *dest)
{
    assert_non_null(dest);

    char *b = (char *)__builtin_alloca(MAX_LENGTH_UINT);
    char *a = b;

    if (i == 0)
    {
        *dest = '0';
        return 1;
    }

    for (; i != 0; i /= 10)
        extend_string(b, i % 10 + '0');

    int size = b - a;
    /* reverse copy converted int to final string */
    for (--b; b >= a; --b, dest++)
        *dest = *b;

    return size;
}

unsigned int convert_CStrToUInt(char *cstr)
{
    assert_non_null(cstr);

    unsigned int i = 0;
    for (; *cstr != '\0'; ++cstr)
        i = i * 10 + *cstr - '0';
    return i;
}

int convert_CStrToInt(char *cstr)
{
    assert_non_null(cstr);

    char n;
    if (*cstr == '-') /* check if number should be negative */
    {
        cstr++;
        n = 1;
    }
    else
        n = 0;
    int i = 0;
    for (; *cstr != '\0'; ++cstr)
        i = i * 10 + *cstr - '0';
    if (n)
        return i * (-1); /* make negative */
    return i;
}

unsigned long long convert_CStrToULong(char *cstr)
{
    assert_non_null(cstr);

    unsigned long long i = 0;
    for (; *cstr != '\0'; ++cstr)
        i = i * 10 + *cstr - '0';
    return i;
}

long long convert_CStrToLong(char *cstr)
{
    assert_non_null(cstr);

    char n = 0;
    if (*cstr == '-') /* check if number should be negative */
    {
        cstr++;
        n = 1;
    }
    else
        n = 0;
    long long i = 0;
    for (; *cstr != '\0'; ++cstr)
        i = i * 10 + *cstr - '0';
    if (n)
        return i * (-1); /* make negative */
    return i;
}

float convert_CStrToFloat(char *cstr)
{
    assert_non_null(cstr);

    /* check if number is negative */
    char n = 0;
    if (*cstr == '-')
    {
        cstr++;
        n = 1;
    }
    else
        n = 0;

    /* parse integer before point */
    float f = 0;
    for (; *cstr != '.'; ++cstr)
    {
        if (*cstr == '\0')
            if (n)
                return f * -1 /* make number negative */;
            else
                return f;
        f = f * 10 + *cstr - '0';
    }

    /* parse integer after point */
    float a, b;
    for (cstr++, a = 1, b = 0; *cstr != '\0'; ++cstr)
    {
        a *= 10;
        b = b * 10 + *cstr - '0';
    }
    if (n)
        return (f /* integer before point */ + (b / a) /* integer after point */) * -1 /* make negative */;
    return f /* integer before point */ + (b / a) /* integer after point */;
}

double convert_CStrToDouble(char *cstr)
{
    assert_non_null(cstr);

    /* check if number is negative */
    char n = 0;
    if (*cstr == '-')
    {
        cstr++;
        n = 1;
    }
    else
        n = 0;

    /* parse integer before point */
    double d = 0;
    for (; *cstr != '.'; ++cstr)
    {
        if (*cstr == '\0')
            if (n)
                return d * -1 /* make number negative */;
            else
                return d;
        d = d * 10 + *cstr - '0';
    }

    /* parse integer after point */
    double a, b;
    for (cstr++, a = 1, b = 0; *cstr != '\0'; ++cstr)
    {
        a *= 10;
        b = b * 10 + *cstr - '0';
    }
    if (n)
        return (d /* integer before point */ + (b / a) /* integer after point */) * -1 /* make negative */;
    return d /* integer before point */ + (b / a) /* integer after point */;
}

int convert_FloatToCStr(float f, char *dest)
{
    assert_non_null(dest);

    unsigned long long significant, fractional;
    char n = 0;

    char *a;
    char *b = (char *)__builtin_alloca(MAX_LENGTH_FLOAT);
    a = b;
    if (f < 0.0F)
    {
        n = 1;
        f *= -1; /* make float positive */
        if (f > (float)(unsigned long long)-1)
        {
            strcpy(dest, "-infinity");
            return 9;
        }
    }
    if (f > (float)(unsigned long long)-1)
    {
        strcpy(dest, "infinity");
        return 8;
    }

    /* determine significant and fractional */
    significant = (unsigned long long)f;
    f -= significant - 1; /* substract 1 to guarantee correct conversion of numbers like with zero like 1.04*/
    f *= FLOAT_CONVERSION_CONSTANT;
    fractional = (unsigned long long)f;

    /* convert fractional to string */
    if (fractional == 0)
        extend_string(b, '0') else for (; fractional != 1; fractional /= 10)
            extend_string(b, fractional % 10 + '0');

    extend_string(b, '.');

    /* convert significant to string */
    if (significant == 0)
        extend_string(b, '0') else for (; significant != 0; significant /= 10)
            extend_string(b, significant % 10 + '0');

    if (n)
        extend_string(b, '-');

    int size = b - a;
    /* reverse copy converted float to final string */
    for (--b; b >= a; --b, dest++)
        *dest = *b;
    return size;
}

int convert_DoubleToCStr(double d, char *dest)
{
    assert_non_null(dest);

    unsigned long long significant, fractional;
    char n = 0;

    char *a;
    char *b = (char *)__builtin_alloca(MAX_LENGTH_FLOAT);
    a = b;
    if (d < 0.0F)
    {
        n = 1;
        d *= -1; /* make double positive */
        if (d > (double)(unsigned long long)-1)
        {
            strcpy(dest, "-infinity");
            return 9;
        }
    }
    if (d > (double)(unsigned long long)-1)
    {
        strcpy(dest, "infinity");
        return 8;
    }

    /* determine significant and fractional */
    significant = (unsigned long long)d;
    d -= significant - 1; /* substract 1 to guarantee correct conversion of numbers like with zero like 1.04*/
    d *= DOUBLE_CONVERSION_CONSTANT;
    fractional = (unsigned long long)d;

    /* convert fractional to string */
    if (fractional == 0)
        extend_string(b, '0') else for (; fractional != 1; fractional /= 10)
            extend_string(b, fractional % 10 + '0');

    extend_string(b, '.');

    /* convert significant to string */
    if (significant == 0)
        extend_string(b, '0') else for (; significant != 0; significant /= 10)
            extend_string(b, significant % 10 + '0');

    if (n)
        extend_string(b, '-');

    int size = b - a; /* macro that extends temporary string of dynamic length */

    /* reverse copy converted float to final string */
    for (--b; b >= a; --b, dest++)
        *dest = *b;
    return size;
}

/* - printf start - */

/* for the print function to work, you will need the String implementation of my SString gist*/
void convert_printf(char *format, ...)
{
    assert_non_null(format);

    sstr_createeOnStack(output);
    /* get arguments */
    va_list args;
    va_start(args, format);

    char *temp = (char *)__builtin_alloca(MAX_LENGTH_FLOAT);
    for (; *format != '\00'; ++format)
    {
        if (*format != '%')
            sstr_appendc(output, *format);
        else
        {
            format++;
            switch (*format)
            {
            /* %i for integers */
            case 'i':
                sstr_appends(output, temp, convert_IntToCStr(va_arg(args, int), temp));
                break;
            /* %l for long integers */
            case 'l':
                sstr_appends(output, temp, convert_LongToCStr(va_arg(args, long long), temp));
                break;
            /* %d for floats/doubles */
            case 'f':
                sstr_appends(output, temp, convert_DoubleToCStr(va_arg(args, double), temp));
                break;
            /* %s for strings */
            case 's':
                sstr_appendcs(output, va_arg(args, char *));
                break;
            /* %.s for strings with length */
            case 'x':
                sstr_appends(output, va_arg(args, char *), va_arg(args, unsigned int));
                break;
            default:
                break;
            }
        }
    }
    sstr_printf(output);
    free(output->s_str);
    va_end(args);
}

void convert_dprintf(int fd, char *format, ...)
{
    assert_non_null(format);

    sstr_createeOnStack(output);
    /* get arguments */
    va_list args;
    va_start(args, format);
    char *ch;
    unsigned int i;
    char *temp = (char *)__builtin_alloca(MAX_LENGTH_FLOAT);
    for (; *format != '\00'; ++format)
    {
        if (*format != '%')
            sstr_appendc(output, *format);
        else
        {
            format++;
            switch (*format)
            {
            /* %i for integers */
            case 'i':
                sstr_appends(output, temp, convert_IntToCStr(va_arg(args, int), temp));
                break;
            /* %l for long integers */
            case 'l':
                sstr_appends(output, temp, convert_LongToCStr(va_arg(args, long long), temp));
                break;
            /* %d for floats/doubles */
            case 'f':
                sstr_appends(output, temp, convert_DoubleToCStr(va_arg(args, double), temp));
                break;
            /* %s for strings */
            case 's':
                sstr_appendcs(output, va_arg(args, char *));
                break;
            /* %x for strings with length */
            case 'x':
                ch = va_arg(args, char *);
                i = va_arg(args, unsigned int);
                sstr_appends(output, ch, i);
                break;
            default:
                break;
            }
        }
    }
    write(fd, output->s_str, output->s_size);
    free(output->s_str);
    va_end(args);
}

/* the amount of digits of original floating point that should be used in converted String */
/* the amount of zeros representate the amount of digits that are put into the new string after converting the floating point*/
#undef FLOAT_CONVERSION_CONSTANT
#undef DOUBLE_CONVERSION_CONSTANT

/* max amount of characters in specific number type */
#undef MAX_LENGTH_BOOL
#undef MAX_LENGTH_INT
#undef MAX_LENGTH_LONG
#undef MAX_LENGTH_UINT
#undef MAX_LENGTH_ULONG
#undef MAX_LENGTH_FLOAT