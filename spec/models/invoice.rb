class Invoice
  include Mongoid::Document

  field :name

  auto_increment :num, :seed => 1000, :step => 5
end

