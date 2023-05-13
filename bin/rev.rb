#!/usr/bin/env ruby

require 'fritanga'

fritanga_serializer = Fritanga::Serializer.new
puts fritanga_serializer.call_rust

