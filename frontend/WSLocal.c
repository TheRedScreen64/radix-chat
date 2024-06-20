#include "WSLocal.h"

#include <microhttpd.h>
#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#ifdef SRV_USEDEBUGMODE

pthread_t file_check;
#define SRV_BUILDSCRIPT "./html/build.sh"

#endif

static char *SRV_STATIC_DIR_R; /* = SRV_STATIC_DIR; */ /* gets initialized in loadFiles() */

#include "utils/ansicodes.h"
#include "utils/debug.h"
#include "utils/String/String.h"

/*
    Files Cache (SQTree Algorithm)
*/
#include "utils/SQTree/SQTreeSlowLocal.h"

/* file structure */
typedef struct
{
    XString dat;
    char *content_type;
} FileData;

/* server */
struct MHD_Daemon *microhttp_server;

/* static files */
SQLTree *staticFiles;
XString static404;
XString staticCMS;

#if defined(SRV_USE_HTTPS) && SRV_USE_HTTPS == 1
XString tls_cert;
XString tls_key;
#endif

#include "PageData.h"
#include "Content.h"

#include "responses.h"

static struct MHD_Response *srv_response404()
{
    return MHD_create_response_from_buffer(static404._size, (void *)static404._str, MHD_RESPMEM_PERSISTENT);
}

static struct MHD_Response *srv_responseDef(char *route)
{
    PageData *data;
    if ((data = srv_optainDataForRoute(route)) == null)
        data = srv_optainDataForRoute("/"); /* use default route */

    XString response = data->page_data;
    return MHD_create_response_from_buffer(response._size, (void *)response._str, MHD_RESPMEM_PERSISTENT);
}

/* simple switch statement to examine content type of static file */
static inline char *srv_optainct(char *str)
{
    switch (strequalsmo(xstrgetfileextension(str), 25,
                        ".nosehad", ".png", ".jpeg", ".svg", ".ttf", ".json", ".js", ".css", ".mpeg",
                        ".txt", ".jpg", ".otf", ".woff", ".woff2", ".gif", ".webp", ".xml", ".pdf",
                        ".zip", ".mp3", ".mp4", ".webm", ".ogg", ".csv", ".exe"))
    {
    case 0:
        return "text/html";
    case 1:
        return "image/png";
    case 2:
        return "image/jpeg";
    case 3:
        return "image/svg+xml";
    case 4:
        return "font/ttf";
    case 5:
        return "application/json";
    case 6:
        return "text/javascript";
    case 7:
        return "text/css";
    case 8:
        return "audio/mpeg";
    case 9:
        return "text/plain; charset=utf-8";
    case 10:
        return "image/jpeg";
    case 11:
        return "font/otf";
    case 12:
        return "font/woff";
    case 13:
        return "font/woff2";
    case 14:
        return "image/gif";
    case 15:
        return "image/webp";
    case 16:
        return "application/xml";
    case 17:
        return "application/pdf";
    case 18:
        return "application/zip";
    case 19:
        return "audio/mpeg";
    case 20:
        return "video/mp4";
    case 21:
        return "video/webm";
    case 22:
        return "audio/ogg";
    case 23:
        return "text/csv";
    case 24:
        return "application/octet-stream";
    default:
        return "text/plain; charset=utf-8";
    }
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdiscarded-qualifiers" /* ignore warning, because strremoveAdStart doesn't \
                                                           modify the string, it just moves the pointer*/
static enum MHD_Result srv_handleonreq(void *cls,
                                       struct MHD_Connection *connection,
                                       const char *url,
                                       const char *method,
                                       const char *version,
                                       const char *upload_data,
                                       size_t *upload_data_size,
                                       void **con_cls)
{
    debga(SRV_PREFIX "%s\n", __func__);

    debgaa(SRV_PREFIX "[\e[1m%s\e[0m] request on '%s'.\n", method, url);

    char *file;
    struct MHD_Response *response;
    register char *content_type = "text/html";
    /* push/upload content */
    if ((file = strremoveAdStart(url, "/content/push/")) != null)
    {
        /* handle content request */
        if (0 != strcmp(method, "POST"))
        {
            response = MHD_create_response_from_buffer(API_WRONG_METHOD, MHD_RESPMEM_PERSISTENT);
            content_type = "application/json";
            goto send_response;
        }
        if (null == *con_cls)
        {
            if (srv_contentPathAccessible(file))
            {
                *con_cls = connection;
                return MHD_YES;
            }
            /* on path a file is already present, response with error */
            struct MHD_Response *response = MHD_create_response_from_buffer(API_INVALID_PATH, MHD_RESPMEM_PERSISTENT);
            enum MHD_Result ret = MHD_queue_response(connection, MHD_HTTP_BAD_REQUEST, response);
            MHD_destroy_response(response);
            return ret;
        }
        if (0 != *upload_data_size)
        {
            if (!srv_pushContent(file, upload_data, *upload_data_size))
                return MHD_NO; /* internal error, double access on same path */

            *upload_data_size = 0;
            return MHD_YES;
        }
        /* No more upload data, return success, write content node */
        if (!srv_writeNode(file))
        {
            // exit(0);
            struct MHD_Response *response = MHD_create_response_from_buffer(API_EMPTY_POST, MHD_RESPMEM_PERSISTENT);
            enum MHD_Result ret = MHD_queue_response(connection, MHD_HTTP_BAD_REQUEST, response);
            MHD_destroy_response(response);
            return ret;
        }
        response = MHD_create_response_from_buffer(API_SUCCESS, MHD_RESPMEM_PERSISTENT);
        content_type = "application/json";
        goto send_response;
    }
    /* optain content */
    else if ((file = strremoveAdStart(url, "/content/get/")) != null)
    {
        /* handle content request */
        struct _srv_content *contentNode = srv_optainContent(file);
        if (contentNode == null)
        {
            response = MHD_create_response_from_buffer(API_INVALID_PATH, MHD_RESPMEM_PERSISTENT);
            content_type = "application/json";
            goto send_response;
        }

        // printf("%lld\n", contentNode);
        // printf("%lld\n", contentNode->content);
        response = MHD_create_response_from_buffer(contentNode->size, contentNode->content, MHD_RESPMEM_PERSISTENT);
        content_type = srv_optainct(file);
        goto send_response;
    }

    /* invalid request */
    else if ((file = strremoveAdStart(url, "/static/")) == null)
    {

        response = srv_responseDef(url);

        int ret = MHD_queue_response(connection, MHD_HTTP_OK, response);
        MHD_destroy_response(response);

        return ret;
    }

    // printf("file: %s\n", url);

    /* response from static file */

    FileData *dat = sqtr_local_get(staticFiles, file);
    if (dat != null)
    {
        response = MHD_create_response_from_buffer(dat->dat._size, (void *)dat->dat._str, MHD_RESPMEM_PERSISTENT);
        content_type = dat->content_type;
        goto send_response;
    }
    XString filePath = xstrcreate();
    xstrappends(&filePath, SRV_STATIC_DIR_R);
    xstrappends(&filePath, file);
    xstrappendc(&filePath, '\00');

    content_type = srv_optainct(filePath._str);

    int fd;

    /* file doesn't exist or is inaccessible */
    if ((fd = open(filePath._str, O_RDONLY)) < 0)
    {
        debgaa(SRV_PREFIX "File '%s' (request path: '%s') not accessable.\n", filePath._str, file);
        response = srv_response404(); /* return error 404 */
        goto send_response;
    }
    struct stat stat;
    fstat(fd, &stat);

    /* print info message */
    debga(SRV_PREFIX "File '%s' accessed for the first time, attempting to load it into the cache.\n", filePath._str);

    /* create file data */
    dat = (FileData *)malloc(sizeof(FileData));
    dat->dat._str = (char *)malloc(stat.st_size);
    dat->dat._size = stat.st_size;

    if (read(fd, dat->dat._str, stat.st_size) == -1)
    {

        debgaa(SRV_PREFIX "failed to read '%s' (%s)\n", filePath._str, strerror(errno));
        /* free filepath */
        free(filePath._str);
        response = srv_response404();
        goto send_response;
    }

    /* write FileData into cache */
    dat->content_type = content_type;
    sqtr_local_set(staticFiles, strcopyusingmalloc(file) /* copy is required since the <file>
                                                      buffer is automatically freed by MHD */
                   ,
                   (char *)dat);

    /* close file */
    close(fd);

    /* free filepath */
    free(filePath._str);

    /* return response */
    response = MHD_create_response_from_buffer(dat->dat._size, (void *)dat->dat._str, MHD_RESPMEM_PERSISTENT);

send_response:
    MHD_add_response_header(response, "Content-Type", content_type);

    int ret = MHD_queue_response(connection, MHD_HTTP_OK, response);
    MHD_destroy_response(response);

    return ret;
}
#pragma GCC diagnostic pop

static void srv_loadFiles()
{
    /* create qtree */
    staticFiles = sqtr_local_create();
    /* 404 Template */
    int fd = open(SRV_404_TEMPLATE, O_RDONLY);
    if (fd < 0)
    {
        debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_404_TEMPLATE" AC_R " not found\n");
        exit(1);
    }
    static404 = xstrcreatefromfiledescriptor(fd);
    close(fd);

    /* CMS Template */
    fd = open(SRV_DEF_TEMPLATE, O_RDONLY);
    if (fd < 0)
    {
        debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_DEF_TEMPLATE" AC_R " not found\n");
    }
    staticCMS = xstrcreatefromfiledescriptor(fd);
    close(fd);

    srv_optainPageData();
}

static void _radix_srv_start()
{
    debga(SRV_PREFIX "%s\n", __func__);

    atexit(radix_srv_exit); /* setup destructor */

    srv_connectToContentDB();

    /* initialize STATIC_DIR_R, because it is needed in responseFromStaticFile method */
    SRV_STATIC_DIR_R = SRV_STATIC_DIR;

    debga(SRV_PREFIX "Starting Daemon on http://localhost:%d\n", SRV_PORT);
#if defined(SRV_USE_HTTPS) && SRV_USE_HTTPS == 1
    tls_cert = xstrcreatefromfilename(SRV_TLS_CERT);
    tls_key = xstrcreatefromfilename(SRV_TLS_KEY);
    // printf("key: %s\n", (const char *)xstrserialize(tls_key));
    microhttp_server = MHD_start_daemon(MHD_USE_SELECT_INTERNALLY | MHD_USE_SSL | MHD_USE_DEBUG,
                                        SRV_PORT, NULL, NULL,
                                        &srv_handleonreq, NULL,
                                        MHD_OPTION_HTTPS_MEM_KEY, xstrserialize(tls_key),
                                        MHD_OPTION_HTTPS_MEM_CERT, xstrserialize(tls_cert),
                                        MHD_OPTION_END);
    debgaa(SRV_PREFIX "Daemon setup on https://%s"
#if defined(SRV_PORT) && SRV_PORT != 443
                      ":%d"
#endif
                      "\n",
           SRV_URL, SRV_PORT);
#else
    microhttp_server = MHD_start_daemon(MHD_USE_SELECT_INTERNALLY, SRV_PORT, NULL, NULL,
                                        &srv_handleonreq, NULL, MHD_OPTION_END);
#endif
    if (microhttp_server == null)
    {
        debga(SRV_PREFIX "\e[31mMHD_start_daemon failed: %s\e[0m\n", strerror(errno));
        // printf("Are you missing needed priviliges? Rerun as root user.\n");
        exit(1);
    }

    srv_loadFiles();
}

static void srv_unloadFiles()
{
    // sqtr_free(staticFiles);

    /* custom free paradigma for SQTree, since FileData also has to be freed */
    for (; !sqtr_local_empty(staticFiles);)
    {
        SQLNode *freen = sqtr_local_popl(staticFiles);

        /* free key*/
        free(freen->key);

        /* free filedata */
        FileData *data = (FileData *)freen->value;
        free(data->dat._str);
        free(data);

        /* free entire node */
        free(freen);
    }

    srv_destroyPageData();

    free(staticFiles);
    free(static404._str);
    free(staticCMS._str);
}

static void srv_filelistener()
{
    for (;;)
    {
        /* use inotifywait to wait for directory changes */
        system("inotifywait -qq -e modify -r \"" SRV_BUILD_DIR "\"");

        /* on change -> rebuild and reload files*/
        system(SRV_BUILDSCRIPT);

        debg(SRV_PREFIX "[" AC_GREEN AC_BOLD "DEBUG" AC_R "] rebuilding html files\n");

        srv_unloadFiles();
        srv_loadFiles();
    }
}

/* public functions - start */
void radix_srv_start()
{
    debga(SRV_PREFIX "%s\n", __func__);

    _radix_srv_start();

    if (pthread_create(&file_check, NULL, (void *(*)(void *)) & srv_filelistener, null) != 0)
    {
        debg(SRV_PREFIX);
        perror("pthread");
        return;
    }
}

void radix_srv_exit()
{
    debga(SRV_PREFIX "%s\n", __func__);

    srv_disconnectFromContentDB();

    if (pthread_detach(file_check) != 0) /* detach pthread */
    {
        debg(SRV_PREFIX);
        perror("Failed to detach PThread");
    }

    MHD_stop_daemon(microhttp_server); /* stop server daemon */
    srv_unloadFiles();                 /* free file data */

#if defined(SRV_USE_HTTPS) && SRV_USE_HTTPS == 1
    assert_non_null(tls_cert._str);
    free(tls_cert._str);
    assert_non_null(tls_key._str);
    free(tls_key._str);
#endif
}
/* public functions - end */
