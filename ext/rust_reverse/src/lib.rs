use magnus::{define_global_function, function, Value, RArray, Symbol};

// pub fn distance(a: (Value), b: (f64, f64)) -> f64 {
// pub fn distance<T>(a: Value) -> f64 {
pub fn distance(a: Value) -> f64 {
    // ((b.0 - a.0).powi(2) + (b.1 - a.1).powi(2)).sqrt()
    let output: RArray = a.funcall("descriptor", ()).unwrap();
    // let mut res = Vec::new();
    // for i in eval::<RArray>("[1, 2, 3]").unwrap().each() {
    for i in output.each() {
        // res.push(i.unwrap().try_convert::<Symbol>().unwrap());
        let method_name = i.unwrap().try_convert::<Symbol>().unwrap();
        println!("{:?}", method_name);
        
        let data: String = a.funcall(method_name, ()).unwrap();
        println!("response: {:?}", data);
    }
    // println!("{:?}", a.funcall::<&str, (), T>("inspect", ()));
    15.0
    // ((b.0 - a.0).powi(3) + (b.1 - a.1).powi(3)).sqrt()
}

#[magnus::init]
fn init() {
    // define_global_function("distance", function!(distance, 2));
    define_global_function("distance", function!(distance, 1));
    // define_global_function("distance", function!(distance::<T>, 1));
}

