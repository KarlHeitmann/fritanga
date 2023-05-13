#!/usr/bin/env ruby

require 'fritanga'

class FooSerializer < Fritanga::Serializer
  def initialize
    @descriptor = [:id, :name]
  end

  def id
    "ID"
  end

  def name
    "NAME"
  end
end

fritanga_serializer = FooSerializer.new
serialized_json = fritanga_serializer.to_json
puts serialized_json

