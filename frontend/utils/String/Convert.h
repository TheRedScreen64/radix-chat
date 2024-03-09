/// @author Noah Nagel
/// edited on february 15. 2024

#include "../StringIterator/StringIterator.h"

char _num_[36] = "0123456789abcdefghijklmnopqrstuvwxyz";

#ifndef DEF_FUNC_PREFIX
#define DEF_FUNC_PREFIX(n) xstr##n
#endif
#ifdef DEF_CONVERT_RADIX
#define CUSTOM_CONVERT_RADIX 1
#elif !defined(DEF_CONVERT_BASE64)
#define DEF_CONVERT_RADIX 10                                                 /* default radix is Base 10 or Decimal system */
#define DEF_FLOATINGPOINT_PRECISION_MULTIPLIER ((unsigned long long)(10E18)) /* max 19 decimals (64 Bit Limit) */
#endif

#ifdef CUSTOM_CONVERT_RADIX /* convert to specified Base */
#define strnumchar(num) _num_[num]
#elif defined(DEF_CONVERT_BASE64) /* convert to Base64 */
char _base64_[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
#define strnumchar(num) _base64_[num]
#define DEF_CONVERT_RADIX 64
#else
#define strnumchar(num) ('0' + (num)) /* convert to Base10 */
#endif

#ifndef DEF_FLOATINGPOINT_PRECISION_MULTIPLIER /* same as DEF_CONVERT_RADIX^18 */
#include <math.h>
#define DEF_FLOATINGPOINT_PRECISION_MULTIPLIER ((unsigned long long)(pow(DEF_CONVERT_RADIX, 19)))
#endif

/// custom functions - start

/* convert number functions */
void DEF_FUNC_PREFIX(appendi)(XString *str, int num)
{
   assert_non_null(str);

    if (num < 0)
    {
        xstrappendToBuff(str, '-');
        num = __builtin_copysignq(num, 1);
    }
    register unsigned int reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
}

void DEF_FUNC_PREFIX(appendl)(XString *str, long long num)
{
   assert_non_null(str);

    if (num < 0)
    {
        xstrappendToBuff(str, '-');
        num = __builtin_copysignq(num, 1);
    }
    register unsigned long long reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
}

void DEF_FUNC_PREFIX(appendui)(XString *str, unsigned int num)
{
   assert_non_null(str);

    register unsigned int reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
}

void DEF_FUNC_PREFIX(appendul)(XString *str, unsigned long long num)
{
   assert_non_null(str);

    register unsigned long long reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
}

void DEF_FUNC_PREFIX(appendf)(XString *str, float f)
{
   assert_non_null(str);

    /* value before point is the same for any conversion function */
    if (f < 0)
    {
        xstrappendToBuff(str, '-');
        f = __builtin_copysignq(f, 1);
    }
    register unsigned long long num = (unsigned long long)f;
    register unsigned long long decimals = (unsigned long long)((f - num) * DEF_FLOATINGPOINT_PRECISION_MULTIPLIER);
    register unsigned long long reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
    /* decimals of floating point */
    reversed = 0;
    for (; decimals != 0; decimals /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (decimals % DEF_CONVERT_RADIX);
    xstrappendToBuff(str, '.');
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
    {
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
        if (reversed == 0)
            break;
    }
}

void DEF_FUNC_PREFIX(appendd)(XString *str, double f)
{
   assert_non_null(str);

    /* value before point is the same for any conversion function */
    if (f < 0)
    {
        xstrappendToBuff(str, '-');
        f = __builtin_copysignq(f, 1);
    }
    register unsigned long long num = (unsigned long long)f;
    register unsigned long long decimals = (unsigned long long)((f - num) * DEF_FLOATINGPOINT_PRECISION_MULTIPLIER);
    register unsigned long long reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
    /* decimals of floating point */
    reversed = 0;
    for (; decimals != 0; decimals /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (decimals % DEF_CONVERT_RADIX);
    xstrappendToBuff(str, '.');
    for (;; reversed /= DEF_CONVERT_RADIX)
    {
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
        if (reversed == 0)
            break;
    }
}

/// TODO: Add rounding

void DEF_FUNC_PREFIX(appendfp)(XString *str, float f, int precision)
{
   assert_non_null(str);

    /* value before point is the same for any conversion function */
    if (f < 0)
    {
        xstrappendToBuff(str, '-');
        f = __builtin_copysignq(f, 1);
    }
    register unsigned long long num = (unsigned long long)f;
    register unsigned long long decimals = (unsigned long long)((f - num) * DEF_FLOATINGPOINT_PRECISION_MULTIPLIER);
    register unsigned long long reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
    if (precision == 0) /* no need for useless calculations */
        return;
    /* decimals of floating point */
    reversed = 0;
#define unreversed_decimals num /* reuse num */
    unreversed_decimals = decimals;
    for (; decimals != 0; decimals /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (decimals % DEF_CONVERT_RADIX);
    xstrappendToBuff(str, '.');
    for (; precision > 0; reversed /= DEF_CONVERT_RADIX, unreversed_decimals /= DEF_CONVERT_RADIX, precision--)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
#undef num
#undef unreversed_decimals
}

void DEF_FUNC_PREFIX(appenddp)(XString *str, double f, int precision)
{
   assert_non_null(str);

    /* value before point is the same for any conversion function */
    if (f < 0)
    {
        xstrappendToBuff(str, '-');
        f = __builtin_copysignq(f, 1);
    }
    register unsigned long long num = (unsigned long long)f;
    register unsigned long long decimals = (unsigned long long)((f - num) * DEF_FLOATINGPOINT_PRECISION_MULTIPLIER);
    register unsigned long long reversed = 0;
    for (; num != 0; num /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (num % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
    if (precision == 0) /* no need for useless calculations */
        return;
    /* decimals of floating point */
    reversed = 0;
#define unreversed_decimals num /* reuse num */
    unreversed_decimals = decimals;
    for (; decimals != 0; decimals /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (decimals % DEF_CONVERT_RADIX);
    xstrappendToBuff(str, '.');
    for (; precision > 0; reversed /= DEF_CONVERT_RADIX, unreversed_decimals /= DEF_CONVERT_RADIX, precision--)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
#undef num
#undef unreversed_decimals
}

#undef DEF_CONVERT_RADIX
#undef DEF_FLOATINGPOINT_PRECISION_MULTIPLIER
#undef strnumchar

/// custom functions - end

/// default functions - start

#define DEF_CONVERT_RADIX 16 /* memory addresses are always displayed in hexadecimal */
#define DEF_FLOATINGPOINT_PRECISION_MULTIPLIER 16E18
#define strnumchar(num) _num_[num]
void xstrappendmemaddr(XString *str, unsigned long long addr)
{
   assert_non_null(str);

    xstrappendToBuff(str, '0');
    xstrappendToBuff(str, 'x');
    register unsigned long long reversed = 0;
    for (; addr != 0; addr /= DEF_CONVERT_RADIX)
        reversed = reversed * DEF_CONVERT_RADIX + (addr % DEF_CONVERT_RADIX);
    for (; reversed != 0; reversed /= DEF_CONVERT_RADIX)
        xstrappendToBuff(str, strnumchar(reversed % DEF_CONVERT_RADIX));
}
#undef DEF_CONVERT_RADIX
#undef DEF_FLOATINGPOINT_PRECISION_MULTIPLIER
#undef strnumchar

void xstrappendformat(XString *str, char *format, ...)
{
   assert_non_null(str);

    /* get arguments */
    __builtin_va_list args;
    __builtin_va_start(args, format);

    for (; *format != '\00'; ++format)
    {
        if (*format != '%')
        {
            xstrappendToBuff(str, *format);
        }
        else
        {
            format++;
            switch (*format)
            {
            /* %d for integers */
            case 'd':
                xstrappendi(str, __builtin_va_arg(args, int));
                break;
            /* %lld for signed long integers */
            case 'l':
                switch (*(format + 1))
                {
                case 'l':
                    if (*(format + 2) == 'd') /* %lld for long integers */
                    {
                        format += 2;
                        xstrappendl(str, __builtin_va_arg(args, long long));
                        break;
                    }
                    else if (*(format + 2) == 'u') /* %llu for unsigned long integers */
                    {
                        format += 2;
                        xstrappendul(str, __builtin_va_arg(args, unsigned long long));
                        break;
                    }
                    else
                    {
                        xstrappendToBuff(str, '%');
                        format -= 1;
                    }
                    /* code */
                    break;
                case 'F': /* lF for double floating point values */
                    format += 1;
                    xstrappendd(str, __builtin_va_arg(args, double));
                    break;

                default:
                    xstrappendToBuff(str, '%');
                    format -= 1;
                    break;
                }
                break;
            case 'F':                                             /* F for single floating point values */
                xstrappendf(str, __builtin_va_arg(args, double)); /* ‘float’ is promoted to ‘double’ when passed through ‘...’ */
                break;
            case 'u': /* u for unsigned integer values */
                xstrappendui(str, __builtin_va_arg(args, unsigned int));
                break;
            case 'c': /* c for unsigned character values */
                // format += 1;
                {
                    if ((str->_size) == malloc_usable_size(str->_str))
                        str->_str = realloc(str->_str, malloc_usable_size(str->_str) * 2);
                    *(str->_str + (str->_size++)) = __builtin_va_arg(args, int); /* ‘char’ is promoted to ‘int’ when passed through ‘...’ */
                }
                break;
            case 's': /* s for string values */
                // format += 1;
                xstrappends(str, __builtin_va_arg(args, char *));
                break;
            case 'p': /* p for memory addresses */
                // format += 1;
                xstrappendmemaddr(str, __builtin_va_arg(args, unsigned long long));
                break;
            }
        }
    }
}

#undef DEF_CONVERT_RADIX
#undef DEF_FLOATINGPOINT_PRECISION_MULTIPLIER

/// default functions - end