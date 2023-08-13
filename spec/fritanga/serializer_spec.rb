# frozen_string_literal: true

require "spec_helper"

describe Fritanga::Serializer do
  class FooSerializer < Fritanga::Serializer
    def initialize(object)
      @descriptor = [:id, :name]
      @object = object
    end

    def id
      @object.id.to_s
    end

    def name
      @object.name
    end
  end

  it "ActiveRecord test" do
    # foo = Foo.create(name: Faker::Lorem.word, address: Faker::Lorem.word).reload
    foo = Foo.create(name: "John Doe", address: "22 Acacia Avenue").reload
    fritanga_serializer = FooSerializer.new(foo)
    serialized_json = fritanga_serializer.to_json
    expect(serialized_json).to eq '{"id":"1","name":"John Doe"}'
  end

  it "ActiveRecord array test" do
    # foo = Foo.create(name: Faker::Lorem.word, address: Faker::Lorem.word).reload
    10.times { Foo.create(name: "John Doe", address: "22 Acacia Avenue").reload }
    records = Foo.all
    fritanga_array_serializer = Fritanga::ArraySerializer.new(records, FooSerializer)
    serialized_json = fritanga_array_serializer.to_json
    expect(serialized_json).to eq '[{"id":"1","name":"John Doe"},{"id":"2","name":"John Doe"},{"id":"3","name":"John Doe"},{"id":"4","name":"John Doe"},{"id":"5","name":"John Doe"},{"id":"6","name":"John Doe"},{"id":"7","name":"John Doe"},{"id":"8","name":"John Doe"},{"id":"9","name":"John Doe"},{"id":"10","name":"John Doe"},{"id":"11","name":"John Doe"}]'
  end
end
