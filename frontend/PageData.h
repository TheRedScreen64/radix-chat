#include "utils/StringIterator/StringIterator.h"
#include "utils/SHashmap.h"
#include "utils/Vector.h"
#include "utils/MapT.h"

AbstractValue pageData;
char* pageDataJsonRawString;
Map(SQLTree, const char *route, const PageData *data) metaData;

typedef struct
{
    char *meta_data;
    char *static_path;
    XString page_data;
} PageData;

static void srv_optainPageData()
{
    debga(SRV_PREFIX "%s\n", __func__);

    int fd = open(SRV_PAGE_CONFIG, O_RDONLY);
    if (fd < 0)
    {
        debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_PAGE_CONFIG" AC_R " not found\n");
        exit(1);
    }
    XString str = xstrcreatefromfiledescriptor(fd);
    close(fd);

    metaData = sqtr_local_create();

    pageDataJsonRawString = xstrserialize(str);

    StringIterator itr = itr_create(pageDataJsonRawString);
    itr_getAbstract(&itr, &pageData);

    if (pageData.valueType != IT_JSON_ARRAY)
    {
        debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_PAGE_CONFIG" AC_R " not in valid format\n");
    }
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-result"

    JsonArray *pages = pageData.valueData.json_arr_val;
    for (int i = 0; i < pages->_size; i++)
    {
        JsonValue *element = pages->_vect + i;
        if (element->valueType != IT_JSON)
            debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_PAGE_CONFIG" AC_R " not in valid format\n");
        JsonObject *page = element->valueData.json_val;

        XString pageMeta = xstrcreate();
        xstrappendformat(&pageMeta, "<title>%s</title>\n", ((JsonValue *)shm_get(page, "title"))->valueData.string_val);
        xstrappendformat(&pageMeta, "<meta name=\"description\" content=\"%s\">\n", ((JsonValue *)shm_get(page, "description"))->valueData.string_val);
        xstrappendformat(&pageMeta, "<meta name=\"author\" content=\"%s\">\n", ((JsonValue *)shm_get(page, "author"))->valueData.string_val);

        JsonValue *page_keywords = (JsonValue *)shm_get(page, "keywords");
        xstrappends(&pageMeta, "<meta name=\"keywords\" content=\"");

        if (page_keywords->valueType != IT_JSON_ARRAY)
        {
            debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_PAGE_CONFIG" AC_R " not in valid format\n");
        }
        vect_foreachBuff(page_keywords->valueData.json_arr_val, JsonValue, keyword)
        {
            xstrappends(&pageMeta, keyword->valueData.string_val);
            if (keyword != (keyword_end - 1))
                xstrappends(&pageMeta, ", ");
        }
        xstrappends(&pageMeta, "\">\n");

        //printf("%s\n", pageMeta._str);

        PageData *currentPageData = (PageData *)malloc(sizeof(PageData));
        currentPageData->meta_data = xstrserialize(pageMeta);
        currentPageData->static_path = ((JsonValue *)shm_get(page, "static"))->valueData.string_val;

        //printf("Inserting %x\n", currentPageData);
        //printf("ROUTE : %s\n", ((JsonValue *)shm_get(page, "route"))->valueData.string_val);
        register char* route = ((JsonValue *)shm_get(page, "route"))->valueData.string_val;
        if(*route == '\00')
             debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_PAGE_CONFIG" AC_R " not in valid format - empty route strings are not allowed\n");
        
        currentPageData->page_data._size = 0;
        currentPageData->page_data._str = (char*)malloc(2048);
        /* append meta data to page */
        strreplaceallmultipletd(&currentPageData->page_data, staticCMS._str, "<meta name=\"cms-dynamic-header\">", pageMeta._str, "C_PRELOAD_CONST_PAGES", pageDataJsonRawString, null);
        
        sqtr_local_set(metaData, route, (char *)currentPageData);
    }
}

#pragma GCC diagnostic pop

static PageData* srv_optainDataForRoute(char*route)
{
    PageData*data = (PageData*)sqtr_local_get(metaData, route);
    return data;
}

static void srv_destroyPageData()
{
    debga(SRV_PREFIX "%s\n", __func__);

    for (; !sqtr_local_empty(metaData);)
    {
        SQLNode *freen = sqtr_local_popl(metaData);
        /* route doesn't need to be freed since it is deallocated by itr_clearAbstract */
        // free(freen->key);

        /* free metadata */
        PageData *data = (PageData *)freen->value;
        //printf("Deleting %x, Route: %s\n", data, freen->key);
        free(data->page_data._str);
        free(data->meta_data);
        free(data);
        // free(data->static_path); /* static path cleared after destructing json object */

        /* free entire node */
        free(freen);
    }
    free(metaData);
    free(pageDataJsonRawString);

    itr_clearAbstract(&pageData);
}