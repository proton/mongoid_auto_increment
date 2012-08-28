class Comment
  include Mongoid::Document

  field :text

  auto_increment :idn

  embedded_in :post
end