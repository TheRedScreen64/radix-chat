// #include "SQTreeSlowLocal.h"
#include "SQTree.h"

#include "../Vector.h"

#include "NString.h"

#include <stdio.h>

//  gcc utils/SQTree/NMap.c utils/SQTree/SQTree.c utils/SString.c utils/String/String.c utils/Convert.c utils/SQTree/test.c -g  -o utils/SQTree/test && utils/SQTree/test > utils/SQTree/test.txt

// Macro to read the contents of a file into a string
#define READ_FILE(filename) ({                          \
    FILE *file = fopen(filename, "r");                  \
    if (!file)                                          \
    {                                                   \
        perror("Error opening file");                   \
        NULL;                                           \
    }                                                   \
    fseek(file, 0, SEEK_END);                           \
    long file_size = ftell(file);                       \
    fseek(file, 0, SEEK_SET);                           \
    char *file_content = (char *)malloc(file_size + 1); \
    fread(file_content, 1, file_size, file);            \
    file_content[file_size] = '\0';                     \
    fclose(file);                                       \
    file_content;                                       \
})

int main()
{
    SQTree *tree = sqtr_open("test94");

    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Cambodia", "1"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Slovenia", "2"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Tonga", "3"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Oman", "4"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Falkland Islands", "5"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "United Kingdom", "6"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Saudi Arabia", "7"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Mali", "8"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "St. Vincent & Grenadines", "9"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Micronesia", "10"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Bangladesh", "11"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Pakistan", "12"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Germany", "13"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Trinidad & Tobago", "14"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Dominica", "15"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Diego Garcia", "16"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Qatar", "17"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Niger", "18"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Lithuania", "19"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Jersey", "20"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Denmark", "21"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Canary Islands", "22"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "North Korea", "23"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Argentina", "24"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Kenya", "25"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Kazakhstan", "26"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Tokelau", "27"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Greenland", "28"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Papua New Guinea", "29"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Japan", "30"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Madagascar", "31"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Montenegro", "32"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "New Zealand", "33"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Wallis & Futuna", "34"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Namibia", "35"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "French Polynesia", "36"));
    // printf("insert if avail: %d\n", sqtr_insertIfAvailable(tree, "Libya", "37"));

    // sqtr_pop(tree, "Libya");
    // printf("pop: %s\n", sqtr_pop(tree, "Montenegro")->value);
    // printf("available: %d\n", sqtr_available(tree, "Montenegro"));
    //
    // SQNode* node = sqtr_optain(tree, "Papua New Guinea");
    // node->value = nstr_copytomapptrs(tree->map, node->value, 13, " idiot", 6);
    // printf("%s\n", node->value);

    // printf("Cambodia: %s\n", sqtr_optain(tree, "Cambodia")->value);
    // printf("Slovenia: %s\n", sqtr_optain(tree, "Slovenia")->value);
    // printf("Tonga: %s\n", sqtr_optain(tree, "Tonga")->value);
    // printf("Oman: %s\n", sqtr_optain(tree, "Oman")->value);
    // printf("Falkland Islands: %s\n", sqtr_optain(tree, "Falkland Islands")->value);
    // printf("United Kingdom: %s\n", sqtr_optain(tree, "United Kingdom")->value);
    // printf("Saudi Arabia: %s\n", sqtr_optain(tree, "Saudi Arabia")->value);
    // printf("Mali: %s\n", sqtr_optain(tree, "Mali")->value);
    // printf("St. Vincent & Grenadines: %s\n", sqtr_optain(tree, "St. Vincent & Grenadines")->value);
    // printf("Micronesia: %s\n", sqtr_optain(tree, "Micronesia")->value);
    // printf("Bangladesh: %s\n", sqtr_optain(tree, "Bangladesh")->value);
    // printf("Pakistan: %s\n", sqtr_optain(tree, "Pakistan")->value);
    // printf("Germany: %s\n", sqtr_optain(tree, "Germany")->value);
    // printf("Trinidad & Tobago: %s\n", sqtr_optain(tree, "Trinidad & Tobago")->value);
    // printf("Dominica: %s\n", sqtr_optain(tree, "Dominica")->value);
    // printf("Diego Garcia: %s\n", sqtr_optain(tree, "Diego Garcia")->value);
    // printf("Qatar: %s\n", sqtr_optain(tree, "Qatar")->value);
    // printf("Niger: %s\n", sqtr_optain(tree, "Niger")->value);
    // printf("Lithuania: %s\n", sqtr_optain(tree, "Lithuania")->value);
    // printf("Jersey: %s\n", sqtr_optain(tree, "Jersey")->value);
    // printf("Denmark: %s\n", sqtr_optain(tree, "Denmark")->value);
    // printf("Canary Islands: %s\n", sqtr_optain(tree, "Canary Islands")->value);
    // printf("North Korea: %s\n", sqtr_optain(tree, "North Korea")->value);
    // printf("Argentina: %s\n", sqtr_optain(tree, "Argentina")->value);
    // printf("Kenya: %s\n", sqtr_optain(tree, "Kenya")->value);
    // printf("Kazakhstan: %s\n", sqtr_optain(tree, "Kazakhstan")->value);
    // printf("Tokelau: %s\n", sqtr_optain(tree, "Tokelau")->value);
    // printf("Greenland: %s\n", sqtr_optain(tree, "Greenland")->value);
    // printf("Papua: %s\n", sqtr_optain(tree, "Papua New Guinea")->value);
    // printf("Japan: %s\n", sqtr_optain(tree, "Japan")->value);
    // printf("Madagascar: %s\n", sqtr_optain(tree, "Madagascar")->value);
    // printf("Montenegro: %s\n", sqtr_optain(tree, "Montenegro")->value);
    // printf("New Zealand: %s\n", sqtr_optain(tree, "New Zealand")->value);
    // printf("Wallis & Futuna: %s\n", sqtr_optain(tree, "Wallis & Futuna")->value);
    // printf("Namibia: %s\n", sqtr_optain(tree, "Namibia")->value);
    // printf("French  Polynesia: %s\n", sqtr_optain(tree, "French Polynesia")->value);
    // printf("Libya: %s\n", sqtr_optain(tree, "Libya")->value);

    // sqtr_set(tree, "bruh32", "bruh");

    sqtr_set(tree, "bruh/football01", "bruh");
    sqtr_set(tree, "bruh/any02", "bruh");
    sqtr_set(tree, "bruh/film03", "bruh");
    sqtr_set(tree, "bruh/charge04", "bruh");
    sqtr_set(tree, "bruh/private05", "bruh");
    sqtr_set(tree, "bruh/sides06", "bruh");
    sqtr_set(tree, "bruh/thy07", "bruh");
    sqtr_set(tree, "bruh/energy08", "bruh");
    sqtr_set(tree, "bruh/rope09", "bruh");
    sqtr_set(tree, "bruh/tool10", "bruh");
    sqtr_set(tree, "bruh/fruit11", "bruh");
    sqtr_set(tree, "bruh/rhyme12", "bruh");
    sqtr_set(tree, "bruh/angry13", "bruh");
    sqtr_set(tree, "bruh/bad14", "bruh");
    sqtr_set(tree, "bruh/apartment15", "bruh");
    sqtr_set(tree, "bruh/comfortable16", "bruh");
    sqtr_set(tree, "bruh/mysterious17", "bruh");
    sqtr_set(tree, "bruh/middle18", "bruh");
    sqtr_set(tree, "bruh/thing19", "bruh");
    sqtr_set(tree, "bruh/mine20", "bruh");
    sqtr_set(tree, "bruh/maybe21", "bruh");
    sqtr_set(tree, "bruh/shown22", "bruh");
    sqtr_set(tree, "bruh/you23", "bruh");
    sqtr_set(tree, "bruh/never24", "bruh");
    sqtr_set(tree, "bruh/name25", "bruh");
    sqtr_set(tree, "bruh/government26", "bruh");
    sqtr_set(tree, "bruh/tree27", "bruh");
    sqtr_set(tree, "bruh/rocky28", "bruh");
    sqtr_set(tree, "bruh/straight29", "bruh");
    sqtr_set(tree, "bruh/automobile30", "bruh");
    sqtr_set(tree, "bruh/lose31", "bruh");
    sqtr_set(tree, "bruh/film32", "bruh");
    sqtr_set(tree, "bruh/band33", "bruh");
    sqtr_set(tree, "bruh/alone34", "bruh");
    sqtr_set(tree, "bruh/president35", "bruh");
    sqtr_set(tree, "bruh/cow36", "bruh");
    sqtr_set(tree, "bruh/church37", "bruh");
    sqtr_set(tree, "bruh/stay38", "bruh");
    sqtr_set(tree, "bruh/cook39", "bruh");
    sqtr_set(tree, "bruh/tropical40", "bruh");
    sqtr_set(tree, "bruh/money41", "bruh");
    sqtr_set(tree, "bruh/actual42", "bruh");
    sqtr_set(tree, "bruh/social43", "bruh");
    sqtr_set(tree, "bruh/believed44", "bruh");
    sqtr_set(tree, "bruh/look45", "bruh");
    sqtr_set(tree, "bruh/rough46", "bruh");
    sqtr_set(tree, "bruh/atom47", "bruh");
    sqtr_set(tree, "bruh/feed48", "bruh");
    sqtr_set(tree, "bruh/company49", "bruh");
    sqtr_set(tree, "bruh/nest50", "bruh");
    sqtr_set(tree, "bruh/same51", "bruh");
    sqtr_set(tree, "bruh/white52", "bruh");
    sqtr_set(tree, "bruh/lovely53", "bruh");
    sqtr_set(tree, "bruh/fire54", "bruh");
    sqtr_set(tree, "bruh/theory55", "bruh");
    sqtr_set(tree, "bruh/eventually56", "bruh");
    sqtr_set(tree, "bruh/system57", "bruh");
    sqtr_set(tree, "bruh/up58", "bruh");
    sqtr_set(tree, "bruh/car59", "bruh");
    sqtr_set(tree, "bruh/pen60", "bruh");
    sqtr_set(tree, "bruh/interest61", "bruh");
    sqtr_set(tree, "bruh/string62", "bruh");
    sqtr_set(tree, "bruh/tent63", "bruh");
    sqtr_set(tree, "bruh/future64", "bruh");
    sqtr_set(tree, "bruh/lips65", "bruh");

    sqtr_set(tree, "lol/throughout", "bruh");
    sqtr_set(tree, "lol/community", "bruh");
    sqtr_set(tree, "lol/equal", "bruh");
    sqtr_set(tree, "lol/rhythm", "bruh");
    sqtr_set(tree, "lol/constantly", "bruh");
    sqtr_set(tree, "lol/useful", "bruh");
    sqtr_set(tree, "lol/him", "bruh");
    sqtr_set(tree, "lol/mistake", "bruh");
    sqtr_set(tree, "lol/sink", "bruh");
    sqtr_set(tree, "lol/mail", "bruh");
    sqtr_set(tree, "lol/travel", "bruh");
    sqtr_set(tree, "lol/wise", "bruh");

    //sqtr_foreach_nr(tree, printf("freach: %s:%s\n", current->key, current->value);, current);

    sqtr_walkdir(tree, "bruh", printf("Found key in dir: %s\n", dircontent->key);, dircontent);

    sqtr_close(tree);
}