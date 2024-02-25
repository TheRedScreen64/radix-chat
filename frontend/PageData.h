#include "utils/StringIterator/StringIterator.h"
#include "utils/SHashmap.h"
#include "utils/Vector.h"
#include "utils/MapT.h"

AbstractValue pageData;
Map(SQLTree, const char* route, const char* add_meta_data) metaData;

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

    StringIterator itr = itr_create(xstrserialize(str));
    itr_getAbstract(&itr, &pageData);

    if (pageData.valueType != IT_JSON_ARRAY)
        debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_PAGE_CONFIG" AC_R " not in valid format\n");

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-result"

    vect_foreachBuff(pageData.valueData.json_arr_val, JsonValue, element)
    {
        if (element->valueType != IT_JSON)
            debg(SRV_PREFIX AC_ERRORTEXT " config file " AC_BOLD "SRV_PAGE_CONFIG" AC_R " not in valid format\n");
        JsonObject *page = element->valueData.json_val;

        XString pageMeta = xstrcreate();
        xstrappendformat(&pageMeta, "<meta name=\"description\" content=\"%s\">", shm_get(page, "description"));
        
        sqtr_local_set(metaData, shm_get(page, "route"), xstrserialize(pageMeta));
    }

    itr_clearAbstract(&pageData);
}

#pragma GCC diagnostic pop

static void srv_destroyPageData()
{
    debga(SRV_PREFIX "%s\n", __func__);
}