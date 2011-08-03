class Book
  include Mongoid::Document

  field :title

  auto_increment :sequence
end