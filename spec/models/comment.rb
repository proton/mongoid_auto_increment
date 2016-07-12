class Comment
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :text

  auto_increment :idn

  embedded_in :post
end
