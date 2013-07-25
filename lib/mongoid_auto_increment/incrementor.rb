# This is a modified version of the code found on this blog post:
#   http://ihswebdesign.com/blog/autoincrement-in-mongodb-with-ruby/
module MongoidAutoIncrement
  class Incrementor
    class Sequence
      def initialize(sequence, collection_name, seed, step)
        @sequence = sequence.to_s
        @collection = collection_name.to_s
        exists? || create(seed)
        @step = step.to_i
      end

       def inc
        if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION > '3'
          collection.find(query).modify({ '$inc' => { number: @step } }, new: true, upsert: true)['number']
        else
          opts = {
            "query"  => query,
            "update" => {"$inc" => { "number" => @step }},
            "new"    => true # return the modified document
          }
          collection.find_and_modify(opts)["number"]
        end
       end

      def current
        if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION > '3'
          collection.find(query).one["number"]
        else
          collection.find_one(query)["number"]
        end
      end

      private

      def exists?
        collection.find(query).count > 0
      end

      def create(number)
        collection.insert(query.merge({ "number" => number }))
      end

      def collection
        if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION > '3'
          Mongoid.default_session[@collection]
        else
          Mongoid.database[@collection]
        end
      end

      def query
        { "seq_name" => @sequence }
      end
    end

    def initialize(options=nil)
    end

    def inc(sequence, options)
      options ||= {}
      collection = options[:collection] || "sequences"
      seed = options[:seed].to_i
      step = options[:step] || 1
      Sequence.new(sequence, collection, seed, step).inc
    end
  end
end
