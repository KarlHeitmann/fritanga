module Fritanga
  class FS
    attr_accessor = :descriptor
    def initialize
      # @descriptor
    end
  end

  class US < FS
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

  class Serializer
    def call_rust
      user_serializer = US.new
      puts serialize(user_serializer)
    end
  end
end
