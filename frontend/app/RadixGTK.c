#define RADIX_USEGTK
#include "RadixGTK.h"

#include <pthread.h>
#include <semaphore.h>
#include <webkit2/webkit2.h>

#include "../html/colortheme.h"
#include "../utils/null.h"
#include "../utils/debug.h"
#include "../utils/String/String.h"

#include "RadixApplication.h"

#define LOADER_FILE "./assets/loader.html"

#define INTRFC_PREFIX "[\e[35m\e[1mUI/GTK-BRIDGE\e[0m] "

#define DEFAULT_TITLE "Radix Chat"
#define DEFAULT_ONQUIT radix_onExit

pthread_t gtk_thread; /* thread used to run gtk_main */

/* GTK data */
GtkWidget *gtk_window;
WebKitWebView *gtk_view;

GdkRGBA gtk_bgcolor;

sem_t gtk_semaphore;

#define createCenteredWindow(width, height) ({                                         \
    register GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);                  \
    /* Set the window size */                                                          \
    gtk_window_set_default_size(GTK_WINDOW(window), width, height);                    \
    /* Center the window */                                                            \
    gtk_window_set_position(GTK_WINDOW(window), GTK_WIN_POS_CENTER);                   \
    /* icon automatically loaded by gnome/windows desktop */                           \
    /* set background */                                                               \
    gtk_widget_override_background_color(window, GTK_STATE_FLAG_NORMAL, &gtk_bgcolor); \
    g_signal_connect(window, "destroy", G_CALLBACK(DEFAULT_ONQUIT), NULL);             \
    window;                                                                            \
})

#define applyWebView(window) ({                                                                      \
    register WebKitWebView *web_view = WEBKIT_WEB_VIEW(webkit_web_view_new());                       \
    webkit_web_view_set_background_color(WEBKIT_WEB_VIEW(web_view), &gtk_bgcolor);                   \
    gtk_container_add(GTK_CONTAINER(window), GTK_WIDGET(web_view));                                  \
    web_view;                                                                                        \
})

#define destroyWindowView(window, view)

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

gboolean radix_gtk_overrideAsCenteredWindow(struct gtepr1 *properties)
{
    debga(INTRFC_PREFIX "%s\n", __func__);

    gtk_widget_hide(GTK_WIDGET(gtk_window));

    gtk_window = createCenteredWindow(properties->width, properties->height);

    gtk_view = applyWebView(gtk_window);

    webkit_web_view_set_settings(WEBKIT_WEB_VIEW(gtk_view), webkit_settings_new_with_settings("enable-developer-extras", TRUE, "enable-webaudio", TRUE, "enable-webgl", TRUE, "disable-web-security", TRUE, "media_playback_requires_user_gesture", FALSE, "enable_media", TRUE, NULL)); /* enable debugging */
    //webkit_web_view_set_settings(WEBKIT_WEB_VIEW(gtk_view), webkit_settings_new_with_settings("enable-webaudio", TRUE, NULL));         /* enable debugging */

    gtk_window_set_title(GTK_WINDOW(gtk_window), properties->title == null ? DEFAULT_TITLE : properties->title);
    gtk_window_set_resizable(GTK_WINDOW(gtk_window), properties->resizeable);

    webkit_web_view_load_uri(gtk_view, properties->uri);

    gtk_widget_show_all(gtk_window);

    sem_post(&gtk_semaphore);

    return FALSE; /* no repeat */
}

static void _radix_gtk_init()
{
    debga(INTRFC_PREFIX "%s\n", __func__);

    gtk_init(null, null);

    gdk_rgba_parse(&gtk_bgcolor, PRIMARY_BG_IDLE_STR);

    register GtkWidget *window = createCenteredWindow(400, 400);

    gtk_window_set_resizable(GTK_WINDOW(window), FALSE);
    gtk_window_set_decorated(GTK_WINDOW(window), FALSE);

    register WebKitWebView *web_view = applyWebView(window);

    /* display loader */
    XString loader = xstrcreatefromfilename(LOADER_FILE);
    webkit_web_view_load_html(web_view, loader._str, null);
    free(loader._str);

    /* show window */
    gtk_widget_show_all(window);

    gtk_view = web_view;
    gtk_window = window;

    gtk_main();
}

/* public functions - start */

void radix_gtk_init(void)
{
    if (pthread_create(&gtk_thread, NULL, (void *(*)(void *)) & _radix_gtk_init, null) != 0)
    {
        perror("pthread");
        return;
    }

    sem_init(&gtk_semaphore, 0, 0);
}

void radix_gtk_uri(struct gtepr1 properties)
{
    debga(INTRFC_PREFIX "%s\n", __func__);

    g_idle_add((int (*)(void *))radix_gtk_overrideAsCenteredWindow, &properties);

    sem_wait(&gtk_semaphore);
}

GtkWidget *radix_gtk_getWindow(void)
{
    return gtk_window;
}

WebKitWebView *radix_gtk_getView(void)
{
    return gtk_view;
}

void radix_gtk_exit(void)
{
    debga(INTRFC_PREFIX "%s\n", __func__);

    gtk_main_quit();
}

/* public functions - end */

#pragma GCC diagnostic pop