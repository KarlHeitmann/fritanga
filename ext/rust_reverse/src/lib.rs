use magnus::{define_global_function, function, Value};

// pub fn distance(a: (Value), b: (f64, f64)) -> f64 {
// pub fn distance<T>(a: Value) -> f64 {
pub fn distance(a: Value) -> f64 {
    // ((b.0 - a.0).powi(2) + (b.1 - a.1).powi(2)).sqrt()
    let output: String = a.funcall("inspect", ()).unwrap();
    println!("{}",output );
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

