class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :title

  auto_increment :sequence
end
