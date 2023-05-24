module Fritanga
  class ArraySerializer
    def initialize(subjects, each_serializer)
      @subjects = subjects
      @each_serializer = each_serializer
    end

    def to_json
      # serialize_array(@subjects.to_a, @each_serializer)
      # serialize_array(@subjects.to_a.map { Proc.new })
      a = @subjects.to_a.map { |subject| -> { @each_serializer.new(subject) } }
=begin
      a.each do |s|
        puts s
        puts s.call
      end
      puts "::::::::::::::"
=end
      # serialize_array(@subjects.to_a.map { -> { @each_serializer.new(_1) } })
      serialize_array(a)

    end
  end
end
