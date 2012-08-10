# This is a modified version of the code found on this blog post:
#   http://ihswebdesign.com/blog/autoincrement-in-mongodb-with-ruby/
module MongoidAutoIncrement
  class Incrementor
    class Sequence
      def initialize(sequence, collection_name, seed)
        @sequence = sequence.to_s
        @collection = collection_name.to_s
        exists? || create(seed)
      end

       def inc
        if ::Mongoid::VERSION < '3'
          opts = {
            "query"  => query,
            "update" => {"$inc" => { "number" => 1 }},
            "new"    => true # return the modified document
          }
          collection.find_and_modify(opts)["number"]
        else
          collection.find(query).modify({ '$inc' => { number: 1 } }, new: true, upsert: true)['number']
        end
       end

      def current
        if ::Mongoid::VERSION < '3'
          collection.find_one(query)["number"]
        else
          collection.find(query).one["number"]
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
        if ::Mongoid::VERSION < '3'
          Mongoid.database[@collection]
        else
          Mongoid.default_session[@collection]
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
      Sequence.new(sequence, collection, seed).inc
    end
  end
end
