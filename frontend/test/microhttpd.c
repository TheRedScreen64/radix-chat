#include <microhttpd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define PORT 80

static enum MHD_Result answer_to_connection(void *cls, struct MHD_Connection *connection,
                                            const char *url, const char *method,
                                            const char *version, const char *upload_data,
                                            size_t *upload_data_size, void **con_cls)
{
    if (strcmp(method, "POST") == 0)
    {
        const char *error_message = "Error: POST requests not allowed";
        struct MHD_Response *response = MHD_create_response_from_buffer(strlen(error_message),
                                                                        (void *)error_message, MHD_RESPMEM_PERSISTENT);
        enum MHD_Result ret = MHD_queue_response(connection, MHD_HTTP_BAD_REQUEST, response);
        MHD_destroy_response(response);
        return ret;
    }
    else
    {
        const char *page = "<html><body>Hello, world!</body></html>";
        struct MHD_Response *response = MHD_create_response_from_buffer(strlen(page),
                                                                        (void *)page, MHD_RESPMEM_PERSISTENT);
        enum MHD_Result ret = MHD_queue_response(connection, MHD_HTTP_OK, response);
        MHD_destroy_response(response);
        return ret;
    }
}

int main()
{
    struct MHD_Daemon *daemon;
    daemon = MHD_start_daemon(MHD_USE_SELECT_INTERNALLY, PORT, NULL, NULL,
                              &answer_to_connection, NULL, MHD_OPTION_END);
    if (daemon == NULL)
    {
        printf("\e[31mMHD_start_daemon failed: %s\e[0m\n", strerror(errno));
        printf("Are you missing needed priviliges? Rerun as root user.\n");
        exit(1);
    }

    printf("Server started on port %d\n", PORT);
    getchar(); // Press any key to exit
    MHD_stop_daemon(daemon);
    return 0;
}
