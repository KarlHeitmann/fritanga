use magnus::{define_global_function, function};

pub fn distance(a: (f64, f64), b: (f64, f64)) -> f64 {
    ((b.0 - a.0).powi(2) + (b.1 - a.1).powi(2)).sqrt()
    // ((b.0 - a.0).powi(3) + (b.1 - a.1).powi(3)).sqrt()
}

#[magnus::init]
fn init() {
    define_global_function("distance", function!(distance, 2));
}

