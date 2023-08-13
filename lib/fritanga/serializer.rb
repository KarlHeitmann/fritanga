module Fritanga
  class Serializer
    attr_accessor = :descriptor
    def initialize
    end

    def descriptor
      @descriptor
    end

    def to_json
      serialize(self)
    end
  end
end
