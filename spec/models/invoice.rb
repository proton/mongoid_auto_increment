class Invoice
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '4'

  field :name

  auto_increment :num, :seed => 1000, :step => 5
end

