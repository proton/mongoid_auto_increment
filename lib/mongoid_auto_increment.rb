require 'mongoid_auto_increment/incrementor'

module MongoidAutoIncrement
  extend ActiveSupport::Concern

  module ClassMethods
    def auto_increment(name, options = {})
      field name, type: Integer

      unless defined? @@incrementor
        @@incrementor = MongoidAutoIncrement::Incrementor.new
      end

      options ||= {}
      seq_name  = options[:name] || "#{self.name.downcase}_#{name}"

      before_create do
        send("#{name}=", @@incrementor.inc(seq_name, options, self))
      end
    end
  end
end

module Mongoid
  module Document
    include MongoidAutoIncrement
  end
end
