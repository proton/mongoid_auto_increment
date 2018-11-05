class Recipe
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '4'

  field :name
  field :chef

  has_many :ingredients

  auto_increment :rank, scope: :chef
end
