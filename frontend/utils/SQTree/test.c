#include "SQTreeSlowLocal.h"
#include "SQTree.h"

#include "../Vector.h"

int main()
{
    SQLTree *tree = sqtr_local_create();
    sqtr_local_set(tree, "Cambodia", "1");
    sqtr_local_set(tree, "Slovenia", "2");
    sqtr_local_set(tree, "Tonga", "3");
    sqtr_local_set(tree, "Oman", "4");
    sqtr_local_set(tree, "Falkland Islands", "5");
    sqtr_local_set(tree, "United Kingdom", "6");
    sqtr_local_set(tree, "Saudi Arabia", "7");
    sqtr_local_set(tree, "Mali", "8");
    sqtr_local_set(tree, "St. Vincent & Grenadines", "9");
    sqtr_local_set(tree, "Micronesia", "10");
    sqtr_local_set(tree, "Bangladesh", "11");
    sqtr_local_set(tree, "Pakistan", "12");
    sqtr_local_set(tree, "Germany", "13");
    sqtr_local_set(tree, "Trinidad & Tobago", "14");
    sqtr_local_set(tree, "Dominica", "15");
    sqtr_local_set(tree, "Diego Garcia", "16");
    sqtr_local_set(tree, "Qatar", "17");
    sqtr_local_set(tree, "Niger", "18");
    sqtr_local_set(tree, "Lithuania", "19");
    sqtr_local_set(tree, "Jersey", "20");
    sqtr_local_set(tree, "Denmark", "21");
    sqtr_local_set(tree, "Canary Islands", "22");
    sqtr_local_set(tree, "North Korea", "23");
    sqtr_local_set(tree, "Argentina", "24");
    sqtr_local_set(tree, "Kenya", "25");
    sqtr_local_set(tree, "Kazakhstan", "26");
    sqtr_local_set(tree, "Tokelau", "27");
    sqtr_local_set(tree, "Greenland", "28");
    sqtr_local_set(tree, "Papua New Guinea", "29");
    sqtr_local_set(tree, "Japan", "30");
    sqtr_local_set(tree, "Madagascar", "31");
    sqtr_local_set(tree, "Montenegro", "32");
    sqtr_local_set(tree, "New Zealand", "33");
    sqtr_local_set(tree, "Wallis & Futuna", "34");
    sqtr_local_set(tree, "Namibia", "35");
    sqtr_local_set(tree, "French Polynesia", "36");
    sqtr_local_set(tree, "Libya", "37");

    printf("Cambodia: %s\n", sqtr_local_get(tree, "Cambodia"));
    printf("Slovenia: %s\n", sqtr_local_get(tree, "Slovenia"));
    printf("Tonga: %s\n", sqtr_local_get(tree, "Tonga"));
    printf("Oman: %s\n", sqtr_local_get(tree, "Oman"));
    printf("Falkland Islands: %s\n", sqtr_local_get(tree, "Falkland Islands"));
    printf("United Kingdom: %s\n", sqtr_local_get(tree, "United Kingdom"));
    printf("Saudi Arabia: %s\n", sqtr_local_get(tree, "Saudi Arabia"));
    printf("Mali: %s\n", sqtr_local_get(tree, "Mali"));
    printf("St. Vincent & Grenadines: %s\n", sqtr_local_get(tree, "St. Vincent & Grenadines"));
    printf("Micronesia: %s\n", sqtr_local_get(tree, "Micronesia"));
    printf("Bangladesh: %s\n", sqtr_local_get(tree, "Bangladesh"));
    printf("Pakistan: %s\n", sqtr_local_get(tree, "Pakistan"));
    printf("Germany: %s\n", sqtr_local_get(tree, "Germany"));
    printf("Trinidad & Tobago: %s\n", sqtr_local_get(tree, "Trinidad & Tobago"));
    printf("Dominica: %s\n", sqtr_local_get(tree, "Dominica"));
    printf("Diego Garcia: %s\n", sqtr_local_get(tree, "Diego Garcia"));
    printf("Qatar: %s\n", sqtr_local_get(tree, "Qatar"));
    printf("Niger: %s\n", sqtr_local_get(tree, "Niger"));
    printf("Lithuania: %s\n", sqtr_local_get(tree, "Lithuania"));
    printf("Jersey: %s\n", sqtr_local_get(tree, "Jersey"));
    printf("Denmark: %s\n", sqtr_local_get(tree, "Denmark"));
    printf("Canary Islands: %s\n", sqtr_local_get(tree, "Canary Islands"));
    printf("North Korea: %s\n", sqtr_local_get(tree, "North Korea"));
    printf("Argentina: %s\n", sqtr_local_get(tree, "Argentina"));
    printf("Kenya: %s\n", sqtr_local_get(tree, "Kenya"));
    printf("Kazakhstan: %s\n", sqtr_local_get(tree, "Kazakhstan"));
    printf("Tokelau: %s\n", sqtr_local_get(tree, "Tokelau"));
    printf("Greenland: %s\n", sqtr_local_get(tree, "Greenland"));
    printf("Papua: %s\n", sqtr_local_get(tree, "Papua New Guinea"));
    printf("Japan: %s\n", sqtr_local_get(tree, "Japan"));
    printf("Madagascar: %s\n", sqtr_local_get(tree, "Madagascar"));
    printf("Montenegro: %s\n", sqtr_local_get(tree, "Montenegro"));
    printf("New Zealand: %s\n", sqtr_local_get(tree, "New Zealand"));
    printf("Wallis & Futuna: %s\n", sqtr_local_get(tree, "Wallis & Futuna"));
    printf("Namibia: %s\n", sqtr_local_get(tree, "Namibia"));
    printf("French  Polynesia: %s\n", sqtr_local_get(tree, "French Polynesia"));
    printf("Libya: %s\n", sqtr_local_get(tree, "Libya"));

    //sqtr_local_foreach_nr(tree, printf("freach: %s:%s\n", current->key, current->value); ,current);

    sqtr_local_free(tree);
    return 0;
}