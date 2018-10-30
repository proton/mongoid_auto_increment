class Ingredient
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '4'

  field :name
  field :type

  belongs_to :recipe

  auto_increment :order, scope: :recipe
  auto_increment :cost, scope: %i[recipe type]
end
