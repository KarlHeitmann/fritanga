require_relative 'setup'
require_relative 'bm_support'
require 'fritanga'

=begin
class AuthorFastSerializer < Fritanga::Serializer
  attributes :id, :name
end
=end

class PostFastSerializer < Fritanga::Serializer
  # attributes :id, :body, :title, :author_id, :created_at
  def initialize(object)
    # @descriptor = [:id, :body]
    @descriptor = [:body]
    @object = object
  end

=begin
  def id # TODO: Add support for integer in rust code
    @object.id
  end
=end

  def body
    @object.body
  end
end

=begin
class PostFastWithJsonSerializer < Fritanga::Serializer
  attributes :id, :body, :title, :author_id, :created_at, :data
end

class PostFastWithMethodCallSerializer < Fritanga::Serializer
  attributes :id, :body, :title, :author_id, :method_call

  def method_call
    object.id * 2
  end
end

class PostWithHasOneFastSerializer < Fritanga::Serializer
  attributes :id, :body, :title, :author_id

  has_one :author, serializer: AuthorFastSerializer
end

class AuthorWithHasManyFastSerializer < Fritanga::Serializer
  attributes :id, :name

  has_many :posts, serializer: PostFastSerializer
end
=end

def benchmark(prefix, serializer, options = {})
  data = Benchmark.data
  posts = data[:all]
  posts_50 = data[:small]

  merged_options = options.merge(each_serializer: serializer)

  posts_count = posts.count

  puts posts_count
  Benchmark.run("Fritanga_ActiveRecord_#{prefix}_Posts_#{posts.count}") do
    # Fritanga::ArraySerializer.new(posts, merged_options).to_json
    # ArraySerializer.new(posts).to_json
    # posts_count.times { |i| puts i; PostFastSerializer.new(posts[i]).to_json } # TODO: Use an ArraySerializer, and catch PostFastSerializer class from options = {} argument
    posts_count.times { |i| PostFastSerializer.new(posts[i]).to_json } # TODO: Use an ArraySerializer, and catch PostFastSerializer class from options = {} argument
  end

  puts ":" * 50
  data = Benchmark.data
  posts = data[:all]
  posts_50 = data[:small]

  posts_50_count = posts_50.count
  puts posts_50_count
  Benchmark.run("Fritanga_ActiveRecord_#{prefix}_Posts_50") do
    # Fritanga::ArraySerializer.new(posts_50, merged_options).to_json
    # posts_50_count.times { |i| puts i; PostFastSerializer.new(posts_50[i]).to_json } # TODO: Use an ArraySerializer, and catch PostFastSerializer class from options = {} argument
    posts_50_count.times { |i| PostFastSerializer.new(posts_50[i]).to_json } # TODO: Use an ArraySerializer, and catch PostFastSerializer class from options = {} argument
  end
end

benchmark "Simple", PostFastSerializer
# benchmark "SimpleWithJson", PostFastWithJsonSerializer
# benchmark "HasOne", PostWithHasOneFastSerializer
# benchmark "SimpleWithMethodCall", PostFastWithMethodCallSerializer
# benchmark "Except", PostWithHasOneFastSerializer, except: [:title]
# benchmark "Only", PostWithHasOneFastSerializer, only: [:id, :body, :author_id, :author]


