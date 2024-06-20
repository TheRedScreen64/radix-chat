int jumpTable[256];
#define itr_getjump(ch) jumpTable[ch]

void __attribute__((ifunc("itr_abstractDispatcher"))) itr_getAbstract(StringIterator *iterator, AbstractValue *value);

/* call to return none type */
#define pop(errmsg) goto _none;
#define push() goto _push;

enum legacy_jump_label_replacement
{
    CNUM,
    CSTRING,
    CCHAR,
    CLETTER,
    CJSON,
    CARRAY,
    empty_skip,
    line_skip,
    CNONE
};

__attribute__((optimize("O0"))) void
_itr_getAbstract(StringIterator *iterator, AbstractValue *value)
{
    assert_non_null(iterator);
    assert_non_null(value);

/* check first char */
_sw:
    switch (itr_getjump((unsigned char)*__str__))
    {

    /* skip chars */
    case (empty_skip): /* static label */
        __str__++;
        goto _sw;

    case (line_skip): /* static label */
        __str__++;
        __line__++;
        goto _sw;

    case (CSTRING): /* static label */
        if ((value->valueData.string_val = _itr_getstr(iterator)) == null)
            pop();
        value->valueType = IT_STRING;
        push();

    case (CCHAR): /* static label */
        value->valueType = IT_CHAR;
        if (!_itr_getchar(iterator, &value->valueData.char_val))
            pop();
        push();

    case (CJSON): /* static label */
        if ((value->valueData.json_val = _itr_collectJsonMap(iterator)) == null)
            pop();
        value->valueType = IT_JSON;
        push();

    case (CARRAY): /* static label*/
        if ((value->valueData.json_arr_val = _itr_collectJsonList(iterator)) == null)
            pop();
        value->valueType = IT_JSON_ARRAY;
        push();

    case (CLETTER): /* static label */
        if ((value->valueData.string_val = _itr_gettext(iterator)) == null)
            pop();
        value->valueType = IT_TEXT;
        push();

    case (CNUM): /* static label */
        if (!_itr_getabstractnum(iterator, value))
            pop();
        push();

    case (CNONE): /* static label */
        value->valueData.uni_val = 0, value->valueType = IT_NONE;
        return;
    }
_none:
    value->valueData.uni_val = 0, value->valueType = IT_NONE;
    return;
_push:
    return;
}

void itr_clearAbstract(AbstractValue *value)
{
    assert_non_null(value);

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
    jumpTable[0] = (CNONE);
    for (unsigned char i = 1; i != 0; ++i)
    {
        if (('0' <= i && i <= '9' || i == '-'))
            jumpTable[i] = (CNUM);
        else if (i == '"')
            jumpTable[i] = (CSTRING);
        else if (i == '\'')
            jumpTable[i] = (CCHAR);
        else if ((('a' <= i && i <= 'z') || ('A' <= i && i <= 'Z') || (i == '_')))
            jumpTable[i] = (CLETTER);
        else if (i == '{')
            jumpTable[i] = (CJSON);
        else if (i == '[')
            jumpTable[i] = (CARRAY);
        else if (i == ' ' || i == '\t')
            jumpTable[i] = (empty_skip);
        else if (i == '\n')
            jumpTable[i] = (line_skip);
        else
            jumpTable[i] = (CNONE);
    }
    return _itr_getAbstract;
}