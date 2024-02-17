#ifndef RADIXGTK_H
#define RADIXGTK_H

#include "../utils/debug.h"

#include <gtk/gtk.h>
#include <webkit2/webkit2.h>

struct gtepr1
{ /* temporary property struct */
    char *uri;
    int width;
    int height;
    char *title; /* can be set to null for default */
    gboolean resizeable;
};

extern void radix_gtk_init(void);
extern void radix_gtk_uri(struct gtepr1 properties);
extern gboolean radix_gtk_overrideAsCenteredWindow(struct gtepr1 *properties);
extern void radix_gtk_exit(void);
extern WebKitWebView* radix_gtk_getView(void);
extern GtkWidget* radix_gtk_getWindow(void);

#endif