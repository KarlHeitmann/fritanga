use magnus::{define_global_function, function, Value, RArray, Symbol};
/*
use serde_yaml; // 0.8.7
use serde_yaml::{Value as SerdeValue};
// use serde_yaml::Value::{Null, Bool, Number, String as YamlString, Sequence, Mapping, Tagged};
use serde_yaml::Value::{Mapping, String as YamlString};
*/

use serde_json::json;


pub fn serialize(a: Value) -> String {
    let output: RArray = a.funcall("descriptor", ()).unwrap();
    // let mut js = json!();
    let mut js = json!({});
    for i in output.each() {
        // let method_name = i.unwrap().try_convert::<Symbol>().unwrap();
        // let method_name = i.unwrap().try_convert::<String>().unwrap();
        let i = i.unwrap();
        let method_name_symbol = i.try_convert::<Symbol>().unwrap();
        // let method_name = i.try_convert::<String>().unwrap(); // ESTA LINEA DA ERROR
        // println!("{:?}", method_name);
        let data: String = a.funcall(method_name_symbol, ()).unwrap();
        println!("response: {:?}", data);
        // js[method_name.to_r_string()] = data;
        // js[method_name.to_string()] = data;
        // js[method_name] = serde_json::Value::String(data);
        // method_name_symbol.try_convert()
        // let method_name =  method_name_symbol.to_s().unwrap().to_ascii_lowercase();
        let method_name =  method_name_symbol.name().unwrap().to_ascii_lowercase();
        js[method_name] = serde_json::Value::String(data);
    }
    js.to_string()
}

#[magnus::init]
fn init() {
    define_global_function("serialize", function!(serialize, 1));
}

