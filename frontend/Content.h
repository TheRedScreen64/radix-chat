#include "utils/SQTree/SQTree.h"
#include "utils/SQTree/NString.h"
#include "utils/ansicodes.h"

Map(SQTree, char * /* path */, struct _srv_content * /* data */) content;

struct _srv_content
{
    _nmap_size size;
    tBoolean isMutable;
    char *content;
};

#define CONT_PREFIX "[" AC_GREEN AC_BOLD "CMS" AC_RESET "] "

static void srv_connectToContentDB()
{
    debga(SRV_PREFIX CONT_PREFIX "%s\n", __func__);

    content = sqtr_open("radix_chat_content_db_y9");
}

static tBoolean srv_contentPathAccessible(char *path)
{
    debgaa(SRV_PREFIX CONT_PREFIX "%s (Path: '%s') ---------<\n", __func__, path);

    SQNode *node;
    struct _srv_content *upload_content;

    if ((node = sqtr_optain(content, path)) == null)
    {
        debg(SRV_PREFIX "No node is present, upload is allowed.\n");
        return tTrue;
    }
    debg(SRV_PREFIX "A node is present, upload is not allowed.\n");
    return tFalse;
}

static tBoolean srv_pushContent(char *path, char *data, _nmap_size data_size)
{
    debgaa(SRV_PREFIX CONT_PREFIX "%s (Path: '%s') ---------<\n", __func__, path);
    SQNode *node;
    struct _srv_content *upload_content;
    if ((node = sqtr_optain(content, path)) == null)
    {
        debga(SRV_PREFIX CONT_PREFIX "Creating content node for '%s'.\n", path);
        upload_content = (struct _srv_content *)nmap_alloc(content->map, sizeof(struct _srv_content));
        upload_content->isMutable = tTrue;
        upload_content->content = nstr_copytomapws(data, data_size, content->map);
        upload_content->size = data_size;
        sqtr_sets(content, path, (char *)upload_content, sizeof(struct _srv_content));
        return tTrue;
    }
    else if ((upload_content = ((struct _srv_content *)node->value))->isMutable)
    {
        debga(SRV_PREFIX CONT_PREFIX "Adding content to node of '%s'.\n", path);
        upload_content->content = nstr_copytomapptrs(content->map, upload_content->content, upload_content->size, data, data_size);
        upload_content->size += data_size;
        return tTrue;
    }
    debga(SRV_PREFIX CONT_PREFIX "Rejecting request on immutable node of '%s'.\n", path);
    return tFalse;
}

static tBoolean srv_writeNode(char *path)
{
    debgaa(SRV_PREFIX CONT_PREFIX "%s (Path: '%s') ---------<\n", __func__, path);

    SQNode *node = sqtr_optain(content, path);

    //sqtr_foreach_nr(content, printf("freach: %s:%.10s\n", current->key, ((struct _srv_content *)current->value)->content);, current);

    if(node == null) /* this can be the case if srv_pushContent was never called due to an empty POST request body */
        return tFalse;

    struct _srv_content *upload_content = ((struct _srv_content *)node->value);

    assert_non_null(upload_content);
    // printf("upload_content=%lx, upload_content->isMutable=%d, upload_content->content=%lx, upload_content->size=%lld\n", upload_content, upload_content->isMutable, upload_content->content, upload_content->size);
    upload_content->isMutable = tFalse;
    return tTrue;
}

static struct _srv_content *srv_optainContent(char *path)
{
    SQNode *node;
    struct _srv_content *upload_content;

    if ((node = sqtr_optain(content, path)) == null)
        return null;

    return ((struct _srv_content *)node->value);
}

static void srv_disconnectFromContentDB()
{
    debga(SRV_PREFIX CONT_PREFIX "%s\n", __func__);

    sqtr_close(content);
}