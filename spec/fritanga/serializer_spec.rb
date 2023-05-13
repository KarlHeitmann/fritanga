# frozen_string_literal: true

require "spec_helper"

describe Fritanga::Serializer do
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
  context "instantiation types" do
    it "from database" do
      fritanga_serializer = FooSerializer.new
      serialized_json = fritanga_serializer.to_json
      expect(serialized_json).to eq '{"id":"ID","name":"NAME"}'
    end
  end
end

