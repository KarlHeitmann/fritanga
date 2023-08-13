# We need to require mkmf *first* this since `rake-compiler` injects code here for cross compilation
require "mkmf"
require "rb_sys/mkmf"

create_rust_makefile("fritanga")
