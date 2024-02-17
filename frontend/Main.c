#include "properties.h"

#include "WSLocal.h"

#ifdef RADIX_MAKE_APP
#include "app/RadixApplication.h"
#endif

#include "stdio.h"

void main()
{
    radix_srv_start(); /* start webserver */

#ifdef RADIX_MAKE_APP
    radix_launchApplication(); /* render ui if present */
#endif

    getchar();
    printf("\e[2A\n");
}