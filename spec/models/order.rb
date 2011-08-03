class Order
  include Mongoid::Document

  field :title

  auto_increment :num, :seed => 1000
end