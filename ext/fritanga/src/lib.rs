// READ THIS: https://bundler.io/blog/2023/01/31/rust-gem-skeleton.html

use magnus::{define_global_function, function, Value, RArray, Symbol};
use serde_json::{json, Value as JsonValue};

fn value_serializer_to_json(serializer: Value) -> JsonValue {
    let mut js_nested:JsonValue = json!({});
    let functions: RArray = serializer.funcall("descriptor", ()).unwrap();
    for function in functions.each() {
        let function = function.unwrap();
        let method_name_symbol = function.try_convert::<Symbol>().unwrap();
        let data: String = serializer.funcall(method_name_symbol, ()).unwrap();
        let method_name: String =  method_name_symbol.name().unwrap().to_string();
        js_nested[method_name] = serde_json::Value::String(data);
    }
    js_nested
}

pub fn serialize_array(builders: RArray) -> String {
    let mut tmp: Vec<JsonValue> = vec![];
    for builder in builders.each() {
        let builder = builder.unwrap();
        let serializer:Value = builder.funcall("call", ()).unwrap();
        let js_nested = value_serializer_to_json(serializer);
        tmp.push(js_nested);
    }
    json!(tmp).to_string()
}

pub fn serialize(serializer: Value) -> String {
    value_serializer_to_json(serializer).to_string()
}

#[magnus::init]
fn init() {
    define_global_function("serialize", function!(serialize, 1));
    define_global_function("serialize_array", function!(serialize_array, 1));
}

