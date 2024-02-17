#include "WSLocal.h"

#include <microhttpd.h>
#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>

#define SRV_PREFIX "[\e[36m\e[1mSERV-LOCAL\e[0m] "
#define SRV_STATIC_DIR "./assets/"
#define SRV_BUILD_DIR "./html"
#define SRV_404_TEMPLATE "./assets/404.html"
#define SRV_USEDEBUGMODE 2024 /* enable outomatic recompile on file change */

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
typedef XString FileData;

/* server */
struct MHD_Daemon *microhttp_server;

/* static files */
SQLTree *staticFiles;
XString static404;

static struct MHD_Response *srv_response404()
{
    return MHD_create_response_from_buffer(static404._size, (void *)static404._str, MHD_RESPMEM_PERSISTENT);
}

static struct MHD_Response *srv_responseFromStaticFile(char *file)
{
    debga(SRV_PREFIX "%s\n", __func__);

    FileData *dat = sqtr_local_get(staticFiles, file);
    if (dat != null)
        return MHD_create_response_from_buffer(dat->_size, (void *)dat->_str, MHD_RESPMEM_PERSISTENT);
    XString filePath = xstrcreate();
    xstrappends(&filePath, SRV_STATIC_DIR_R);
    xstrappends(&filePath, file);
    xstrappendc(&filePath, '\00');

    int fd;

    /* file doesn't exist or is inaccessible */
    if ((fd = open(filePath._str, O_RDONLY)) < 0)
    {
        debgaa(SRV_PREFIX "File '%s' (request path: '%s') is not accessable.\n", filePath._str, file);
        return srv_response404(); /* return error 404 */
    }
    struct stat stat;
    fstat(fd, &stat);

    /* print info message */
    debga(SRV_PREFIX "File '%s' accessed for the first time, attempting to load it into the cache.\n", filePath._str);

    /* create file data */
    dat = (FileData *)malloc(sizeof(FileData));
    dat->_str = (char *)malloc(stat.st_size);
    dat->_size = stat.st_size;

    if (read(fd, dat->_str, stat.st_size) == -1)
    {

        debgaa(SRV_PREFIX "failed to read '%s' (%s)\n", filePath._str, strerror(errno));
        /* free filepath */
        free(filePath._str);
        return srv_response404();
    }

    /* write FileData into cache */
    sqtr_local_set(staticFiles, strcopyusingmalloc(file) /* copy is required since the <file>
                                                      buffer is automatically freed by MHD */
                   ,
                   (char *)dat);

    /* close file */
    close(fd);

    /* free filepath */
    free(filePath._str);

    /* return response */
    return MHD_create_response_from_buffer(dat->_size, (void *)dat->_str, MHD_RESPMEM_PERSISTENT);
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

    char *staticfile;
    struct MHD_Response *response;
    /* only static allowed currently */
    if ((staticfile = strremoveAdStart(url, "/static/")) == null)
    {
        response = srv_response404();

        int ret = MHD_queue_response(connection, MHD_HTTP_NOT_FOUND, response);
        MHD_destroy_response(response);

        return ret;
    }

    /* response from static file */
    response = srv_responseFromStaticFile(staticfile);

    int ret = MHD_queue_response(connection, MHD_HTTP_OK, response);
    MHD_destroy_response(response);

    return ret;
}
#pragma GCC diagnostic pop

static void srv_loadFiles()
{
    /* create qtree */
    staticFiles = sqtr_local_create();
    int fd = open(SRV_404_TEMPLATE, O_RDONLY);
    if (fd < 0)
    {
        debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_404_TEMPLATE" AC_R " not found\n");
        exit(1);
    }
    static404 = xstrcreatefromfiledescriptor(fd);
}

static void _radix_srv_start()
{
    debga(SRV_PREFIX "%s\n", __func__);

    atexit(radix_srv_exit); /* setup destructor */

    /* initialize STATIC_DIR_R, because it is needed in responseFromStaticFile method */
    SRV_STATIC_DIR_R = SRV_STATIC_DIR;

    debga(SRV_PREFIX "Starting Daemon on http://localhost:%d\n", SRV_PORT);
    microhttp_server = MHD_start_daemon(MHD_USE_SELECT_INTERNALLY, SRV_PORT, NULL, NULL,
                                        &srv_handleonreq, NULL, MHD_OPTION_END);
    if (microhttp_server == null)
    {
        debga(SRV_PREFIX "\e[31mMHD_start_daemon failed: %s\e[0m\n", strerror(errno));
        exit(1);
    }

    srv_loadFiles();
}

static void srv_unloadFiles()
{
    // sqtr_free(staticFiles);

    /* custom free paradigma for SQTree, since FileData also has to be freed */
    for (; !sqtr_local_empty(staticFiles); free(sqtr_local_popl(staticFiles)))
    {
        SQLNode *freen = sqtr_local_popl(staticFiles);

        /* free key*/
        free(freen->key);

        /* free filedata */
        FileData *data = (FileData *)freen->value;
        free(data->_str);
        free(data);

        /* free entire node */
        free(freen);
    }
    free(staticFiles);
    free(static404._str);
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

    if (pthread_detach(file_check) != 0) /* detach pthread */
    {
        debg(SRV_PREFIX);
        perror("Failed to detach PThread");
    }

    MHD_stop_daemon(microhttp_server); /* stop server daemon */
    srv_unloadFiles();                 /* free file data */
}
/* public functions - end */
