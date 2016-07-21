class Comment
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION >= '4'

  field :text

  auto_increment :idn

  embedded_in :post
end
