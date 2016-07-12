class Invoice
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :name

  auto_increment :num, :seed => 1000, :step => 5
end

