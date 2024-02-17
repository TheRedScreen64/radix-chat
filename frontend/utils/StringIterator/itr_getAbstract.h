void *jumpTable[256];
#define itr_getjump(ch) jumpTable[ch]

void __attribute__((ifunc("itr_abstractDispatcher"))) itr_getAbstract(StringIterator *iterator, AbstractValue *value);

/* call to return none type */
#define pop(errmsg) sticlbl_jump(CNONE);
#define push() sticlbl_jump(push);

__attribute__((optimize("O0"))) void
_itr_getAbstract(StringIterator *iterator, AbstractValue *value)
{
    /* check first char */
    sticlbl_jumpa(itr_getjump((unsigned char)*__str__));

    /* skip chars */
    sticlbl_create(empty_skip); /* static label */
    __str__++;
    sticlbl_jumpa(itr_getjump((unsigned char)*__str__));

    sticlbl_create(line_skip); /* static label */
    __str__++;
    __line__++;
    sticlbl_jumpa(itr_getjump((unsigned char)*__str__));

    sticlbl_create(CSTRING); /* static label */
    if ((value->valueData.string_val = _itr_getstr(iterator)) == null)
        pop();
    value->valueType = IT_STRING;
    push();

    sticlbl_create(CCHAR); /* static label */
    value->valueType = IT_CHAR;
    if (!_itr_getchar(iterator, &value->valueData.char_val))
        pop();
    push();

    sticlbl_create(CJSON); /* static label */
    if ((value->valueData.json_val = _itr_collectJsonMap(iterator)) == null)
        pop();
    value->valueType = IT_JSON;
    push();

    sticlbl_create(CARRAY); /* static label*/
    if ((value->valueData.json_arr_val = _itr_collectJsonList(iterator)) == null)
        pop();
    value->valueType = IT_JSON_ARRAY;
    push();

    sticlbl_create(CLETTER); /* static label */
    if ((value->valueData.string_val = _itr_gettext(iterator)) == null)
        pop();
    value->valueType = IT_TEXT;
    push();

    sticlbl_create(CNUM); /* static label */
    if (!_itr_getabstractnum(iterator, value))
        pop();
    push();

    sticlbl_create(CNONE); /* static label */
    value->valueData.uni_val = 0, value->valueType = IT_NONE;
    sticlbl_create(push); /* static Label */
    return;
}

void itr_clearAbstract(AbstractValue *value)
{
    switch (value->valueType)
    {
    case IT_JSON:
    {
        struct _hashnode **cap = value->valueData.json_val->table + value->valueData.json_val->capacity;
        for (struct _hashnode **bucket = value->valueData.json_val->table; bucket != cap; ++bucket)
        {
            struct _hashnode *node = *bucket;
            if (node != null)
                for (struct _hashnode *next; node != null; node = next)
                {
                    next = node->next;
                    free(node->key);
                    itr_clearAbstract((AbstractValue *)node->value);
                    free(node->value); /* Abstract Value in Json Objects are allocated using malloc */
                    free(node);
                }
        }
        free(value->valueData.json_val->table);
        free(value->valueData.json_val);
        break;
    }
    case IT_JSON_ARRAY:
    {
        vect_foreachBuff(value->valueData.json_arr_val, JsonValue, itr)
            itr_clearAbstract(itr);
        free(value->valueData.json_arr_val->_vect);
        free(value->valueData.json_arr_val);
        break;
    }
    case IT_STRING:
    case IT_TEXT:
    {
        free(value->valueData.string_val);
        break;
    }
    break;
    default: /* no free since AbstractValues for numbers, etc. aren't dynamically allocated */
        return;
    }
}

__attribute__((/*optimize("O0")*/)) static typeof(itr_getAbstract) *itr_abstractDispatcher()
{
    /* setup data table  */
    jumpTable[0] = sticlbl_getaddr(CNONE);
    for (unsigned char i = 1; i != 0; ++i)
    {
        if (('0' <= i && i <= '9' || i == '-'))
            jumpTable[i] = sticlbl_getaddr(CNUM);
        else if (i == '"')
            jumpTable[i] = sticlbl_getaddr(CSTRING);
        else if (i == '\'')
            jumpTable[i] = sticlbl_getaddr(CCHAR);
        else if ((('a' <= i && i <= 'z') || ('A' <= i && i <= 'Z') || (i == '_')))
            jumpTable[i] = sticlbl_getaddr(CLETTER);
        else if (i == '{')
            jumpTable[i] = sticlbl_getaddr(CJSON);
        else if (i == '[')
            jumpTable[i] = sticlbl_getaddr(CARRAY);
        else if (i == ' ' || i == '\t')
            jumpTable[i] = sticlbl_getaddr(empty_skip);
        else if (i == '\n')
            jumpTable[i] = sticlbl_getaddr(line_skip);
        else
            jumpTable[i] = sticlbl_getaddr(CNONE);
    }
    return _itr_getAbstract;
}