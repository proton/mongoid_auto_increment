class Post
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '4'

  field :title

  auto_increment :key, seed: 500
  auto_increment :num

  embeds_many :comments
end
