class Order
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :title

  auto_increment :num, :seed => 1000
end
