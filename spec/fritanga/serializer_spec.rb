# frozen_string_literal: true

require "spec_helper"

describe Fritanga::Serializer do
  class FooSerializer < Fritanga::Serializer
    def initialize(object)
      @descriptor = [:id, :name]
      @object = object
    end

    def id
      @object.fetch_id
    end

    def name
      @object.fetch_name
    end
  end

  it "Basic test" do
    class Foo
      def fetch_id
        "1"
      end
      def fetch_name
        "John Doe"
      end
    end
    fritanga_serializer = FooSerializer.new(Foo.new)
    serialized_json = fritanga_serializer.to_json
    expect(serialized_json).to eq '{"id":"1","name":"John Doe"}'
  end

  it "ActiveRecord test" do
    # foo = Foo.create(name: Faker::Lorem.word, address: Faker::Lorem.word).reload
    foo = Foo.create(name: "John Doe", address: "22 Acacia Avenue").reload
    fritanga_serializer = FooSerializer.new(foo)
    serialized_json = fritanga_serializer.to_json
    expect(serialized_json).to eq '{"id":"1","name":"John Doe"}'

  end
end

