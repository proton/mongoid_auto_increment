class Post
  include Mongoid::Document

  field :title

  auto_increment :key, :seed => 500
  auto_increment :num

  embeds_many :comments
end