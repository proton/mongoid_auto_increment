class Order
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '4'

  field :title

  auto_increment :num, :seed => 1000
end
