# frozen_string_literal: true

require_relative "fritanga/version"

begin
  RUBY_VERSION =~ /(\d+\.\d+)/
  require "fritanga/#{$1}/fritanga"
rescue LoadError
  require "fritanga/fritanga"
end

require_relative "fritanga/serializer"

module Fritanga
  class Error < StandardError; end
  # Your code goes here...
end
