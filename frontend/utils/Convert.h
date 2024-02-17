
/// Deprecated Convert implementation
/// use StringIterator.h and String/Convert.h instead
/// @author Noah Nagel

#ifndef CONVERT_H
#define CONVERT_H
#ifdef __cplusplus
extern "C"
{
#endif
#include <stdlib.h>
#include <stdio.h>
;
#include <sys/mman.h>
#include <string.h>
#include <unistd.h>
#include <stdarg.h>

#include "SString.h"
#include "null.h"

    enum numberType
    {
        NT_INT,
        NT_LONG,
        NT_FLOAT,
        NT_NONE
    };

#define CONVERT_HEADER_MAX_LENGTH_UNIT_INT 12
#define CONVERT_HEADER_MAX_LENGTH_UNIT_LONG 21
#define CONVERT_HEADER_MAX_LENGTH_UNIT_UINT 11
#define CONVERT_HEADER_MAX_LENGTH_UNIT_ULONG 20
#define CONVERT_HEADER_MAX_LENGTH_UNIT_FLOAT CONVERT_HEADER_MAX_LENGTH_UNIT_LONG /* significant */ + CONVERT_HEADER_MAX_LENGTH_UNIT_ULONG /* fractional */ + 1 /*. symbol*/
                                                                                                   /* = 42 */
#define convert_getMaxLength(type) CONVERT_HEADER_MAX_LENGTH_UNIT_##type

    /* return type by numberType */
    int convert_getType(char *cstr);
    int convert_LongToCStr(long long l, char *dest);
    int convert_ULongToCStr(unsigned long long l, char *dest);
    int convert_IntToCStr(int i, char *dest);
    int convert_UIntToCStr(unsigned int i, char *dest);
    unsigned int convert_CStrToUInt(char *cstr);
    int convert_CStrToInt(char *cstr);
    unsigned long long convert_CStrToULong(char *cstr);
    long long convert_CStrToLong(char *cstr);
    float convert_CStrToFloat(char *cstr);
    double convert_CStrToDouble(char *cstr);
    int convert_FloatToCStr(float f, char *dest);
    int convert_DoubleToCStr(double d, char *dest);
    void convert_printf(char *format, ...);
    void convert_dprintf(int fd, char *format, ...);

#ifdef __cplusplus
}
#endif
#endif