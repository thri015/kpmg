def find_value(obj, key):
    k = key
    res = None
    if "/" in key:        
        k = key.split("/")
    else:
        res = obj[key]
        print(res)
        return res
        
    nk = k.pop(0)
    val = obj[nk]
    if "/" in key and res == None:
        find_value(val, '/'.join(k))


object = {"a": {"b": {"c": "d"}}}
key = "a/b/c"
find_value(object, key)

object = {"x":{"y":{"z":"a"}}}
key = "x/y/z"
find_value(object, key)
