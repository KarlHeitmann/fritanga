#!/usr/bin/env ruby

require 'rust_reverse'
# puts RustReverse.reverse(ARGV[0].to_i)
# puts RustReverse.distance(ARGV[0])
# puts RustReverse.send(:distance(ARGV[0]))
#

class FritangaSerializer
  attr_accessor = :descriptor
  def initialize
    # @descriptor
  end
end

class UserSerializer < FritangaSerializer
  def initialize
    @descriptor = [:id, :name]
  end
  def id
    "ID"
  end

  def name
    "NAME"
  end

  def descriptor
    @descriptor
  end
end

user_serializer = UserSerializer.new
puts RustReverse.send(:distance, user_serializer)
# puts RustReverse.distance([1, 2], [1,3])

