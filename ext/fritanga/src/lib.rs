use magnus::{define_global_function, function, Value, RArray, Symbol};
use serde_json::{json, Value as JsonValue};

pub fn serialize_array(builders: RArray) -> String {
    let mut js = json!([]);
    let mut tmp: Vec<JsonValue> = vec![];
    for builder in builders.each() {
        let builder = builder.unwrap();
        let mut js_nested:JsonValue = json!({});
        let serializer:Value = builder.funcall("call", ()).unwrap();
        let d:String = serializer.funcall("inspect", ()).unwrap();
        let functions: RArray = serializer.funcall("descriptor", ()).unwrap();
        for function in functions.each() {
            let function = function.unwrap();
            let method_name_symbol = function.try_convert::<Symbol>().unwrap();
            let data: String = serializer.funcall(method_name_symbol, ()).unwrap();
            let method_name =  method_name_symbol.name().unwrap().to_ascii_lowercase();
            js_nested[method_name] = serde_json::Value::String(data);
        }
        tmp.push(js_nested);
    }
    json!(tmp).to_string()
}

pub fn serialize(a: Value) -> String {
    let output: RArray = a.funcall("descriptor", ()).unwrap();
    let mut js = json!({});
    for i in output.each() {
        let i = i.unwrap();
        let method_name_symbol = i.try_convert::<Symbol>().unwrap();
        let data: String = a.funcall(method_name_symbol, ()).unwrap();
        let method_name =  method_name_symbol.name().unwrap().to_ascii_lowercase();
        js[method_name] = serde_json::Value::String(data);
    }
    js.to_string()
}

#[magnus::init]
fn init() {
    define_global_function("serialize", function!(serialize, 1));
    define_global_function("serialize_array", function!(serialize_array, 1));
}

