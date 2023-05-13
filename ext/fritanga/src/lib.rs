use magnus::{define_global_function, function, Value, RArray, Symbol};
use serde_json::json;


pub fn serialize(a: Value) -> String {
    let output: RArray = a.funcall("descriptor", ()).unwrap();
    // let mut js = json!();
    let mut js = json!({});
    for i in output.each() {
        let i = i.unwrap();
        let method_name_symbol = i.try_convert::<Symbol>().unwrap();
        let data: String = a.funcall(method_name_symbol, ()).unwrap();
        println!("response: {:?}", data);
        let method_name =  method_name_symbol.name().unwrap().to_ascii_lowercase();
        js[method_name] = serde_json::Value::String(data);
    }
    js.to_string()
}

#[magnus::init]
fn init() {
    define_global_function("serialize", function!(serialize, 1));
}

