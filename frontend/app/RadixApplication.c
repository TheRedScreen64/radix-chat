#include <gtk/gtk.h>
#include <pthread.h>
#include <semaphore.h>
#include <webkit2/webkit2.h>

#define RADIX_USEGTK 2024

#include "RadixGTK.h"

#include "../WSLocal.h"
#include "../html/colortheme.h"
#include "../utils/null.h"
#include "../utils/debug.h"
#include "../utils/String/String.h"

#define GROUP_ID "com.nosehad.Editor"

#define LOGIN_URI "http://localhost:" SRV_PORT_S "/login"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

void radix_onExit()
{
    debga("> \n", __func__);
    debga("> %s\n", __func__);
    debga("> \n", __func__);

    // radix_srv_exit();
    // radix_brdg_exit(); /* bridge is established for every new view */
    radix_gtk_exit();

    _Exit(0); /* skip destructor after being called once */
}

void radix_launchApplication(void)
{
    debga("> \n", __func__);
    debga("> %s\n", __func__);
    debga("> \n", __func__);

    radix_gtk_init(); /* launch gtk client / ui*/
    // radix_brdg_init(); /* initialize javascript bridge */
    //radix_srv_start(); /* launch webserver*/

    sleep(2);

    /* display projects page */
    radix_gtk_uri((struct gtepr1){LOGIN_URI, 1010, 690, null, TRUE});

    atexit(&radix_onExit); /* setup destructor */
}

#pragma GCC diagnostic pop