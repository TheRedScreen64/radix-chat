#define itr_printTypeAndValue(type, valFormat, val)                                \
    case type:                                                                     \
        printf("  \"type\":\"" #type "\",\n  \"value\":" #valFormat "\n}\n", val); \
        break;

#define itr_printType(type)                      \
    case type:                                   \
        printf("  \"type\":\"" #type "\"\n}\n"); \
        break;

void itr_printObject(AbstractValue *obj)
{
    assert_non_null(obj);

    printf("{\n");
    switch (obj->valueType)
    {
        itr_printType(IT_NONE);
        itr_printTypeAndValue(IT_CHAR, "%c", obj->valueData.schar_val);
        itr_printTypeAndValue(IT_VERYSHORT, "%d", obj->valueData.schar_val);
        itr_printTypeAndValue(IT_UVERYSHORT, "%u", obj->valueData.uchar_val);
        itr_printTypeAndValue(IT_SHORT, "%d", obj->valueData.sshort_val);
        itr_printTypeAndValue(IT_USHORT, "%u", obj->valueData.ushort_val);
        itr_printTypeAndValue(IT_INT, "%d", obj->valueData.sint_val);
        itr_printTypeAndValue(IT_UINT, "%u", obj->valueData.uint_val);
        itr_printTypeAndValue(IT_LONG, "%lld", obj->valueData.slong_val);
        itr_printTypeAndValue(IT_ULONG, "%llu", obj->valueData.ulong_val);
        itr_printTypeAndValue(IT_JSON, "%x", obj->valueData.json_val);
        itr_printTypeAndValue(IT_JSON_ARRAY, "%x", obj->valueData.json_arr_val);
        itr_printType(IT_EMPTY);
        itr_printType(IT_NOSTD_NULL);
        itr_printType(IT_NOSTD_TRUE);
        itr_printType(IT_NOSTD_FALSE);
        itr_printTypeAndValue(IT_FLOAT, "%f", obj->valueData.float_val);
        itr_printTypeAndValue(IT_DOUBLE, "%f", obj->valueData.double_val);
        itr_printTypeAndValue(IT_STRING, "%s", obj->valueData.string_val);
        itr_printTypeAndValue(IT_TEXT, "%s", obj->valueData.string_val);
    }
}

#undef itr_printType
#undef itr_printTypeAndValue

#define itr_str(type, func) \
    case type:              \
        func;               \
        break;

#define itr_w(c, w)      \
    xstrappendc(str, w); \
    c;                   \
    xstrappendc(str, w);

void itr_stringify(AbstractValue *obj, XString *str)
{
    assert_non_null(obj);
    assert_non_null(str);

    switch (obj->valueType)
    {
        itr_str(IT_NONE, xstrappends(str, "undefined"));
        itr_str(IT_CHAR, itr_w(xstrappendc(str, obj->valueData.schar_val), '\''));
        itr_str(IT_VERYSHORT, xstrappendi(str, obj->valueData.schar_val));
        itr_str(IT_UVERYSHORT, xstrappendui(str, obj->valueData.uchar_val));
        itr_str(IT_SHORT, xstrappendi(str, obj->valueData.sshort_val));
        itr_str(IT_USHORT, xstrappendui(str, obj->valueData.ushort_val));
        itr_str(IT_INT, xstrappendi(str, obj->valueData.sint_val));
        itr_str(IT_UINT, xstrappendui(str, obj->valueData.uint_val));
        itr_str(IT_LONG, xstrappendl(str, obj->valueData.slong_val));
        itr_str(IT_ULONG, xstrappendul(str, obj->valueData.ulong_val));
        itr_str(IT_JSON, itr_stringifyObject(obj->valueData.json_val, str));
        itr_str(IT_JSON_ARRAY, itr_stringifyArray(obj->valueData.json_arr_val, str));
        itr_str(IT_EMPTY, xstrappends(str, "empty"));
        itr_str(IT_NOSTD_NULL, xstrappends(str, "null"));
        itr_str(IT_NOSTD_TRUE, xstrappends(str, "true"));
        itr_str(IT_NOSTD_FALSE, xstrappends(str, "false"));
        itr_str(IT_FLOAT, xstrappendf(str, obj->valueData.float_val));
        itr_str(IT_DOUBLE, xstrappendd(str, obj->valueData.double_val));
        itr_str(IT_STRING, itr_w(xstrappends(str, obj->valueData.string_val), '"'));
        itr_str(IT_TEXT, xstrappends(str, obj->valueData.string_val));
    }
    // itr_clearAbstract(obj); /* automatically delete abstract */
}

void itr_stringifyArray(JsonArray *arr, XString *str)
{
    assert_non_null(arr);
    assert_non_null(str);

    if (arr->_size == 0)
    {
        xstrappends(str, "[]");
        return;
    }

    xstrappendc(str, '[');
    vect_foreachBuff(arr, JsonValue, itr)
    {
        itr_stringify(itr, str);
        xstrappendc(str, ',');
    }
    *(str->_str + str->_size - 1) = ']';
}

void itr_stringifyObject(JsonObject *obj, XString *str)
{
    assert_non_null(obj);
    assert_non_null(str);

    if (obj->size == 0)
    {
        xstrappends(str, "{}");
        return;
    }

    xstrappendc(str, '{');
    shm_foreach(obj, node, {
        itr_w(xstrappends(str, node->key), '"')
            xstrappendc(str, ':');
        itr_stringify((AbstractValue *)node->value, str);
        xstrappendc(str, ',');
    });
    *(str->_str + str->_size - 1) = '}';
}

void itr_dump(AbstractValue *val, const char *file)
{
    assert_non_null(val);
    assert_non_null(file);

    XString str = xstrcreate();

    itr_stringify(val, &str);

    int fd = open(file, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);

    if (fd == -1)
    {
        perror("open");
        return;
    }

    if (write(fd, str._str, str._size) == -1)
    {
        perror("write");
    }

    close(fd);
    free(str._str);
}