#!/usr/bin/env ruby

require 'rust_reverse'
# puts RustReverse.reverse(ARGV[0].to_i)
# puts RustReverse.distance(ARGV[0])
# puts RustReverse.send(:distance(ARGV[0]))
#
puts RustReverse.send(:distance, [0, 0], [3,4])
# puts RustReverse.distance([1, 2], [1,3])

