$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "models")

require "rubygems"
require "mongoid"
require "mongoid_auto_increment"
require "database_cleaner"
require "simplecov"

SimpleCov.start

Dir["#{MODELS}/*.rb"].each { |f| require f }

if defined?(::Mongoid::VERSION) && ::Mongoid::VERSION > '3'
  Mongoid.configure do |config|
    config.connect_to "mongoid_auto_increment_test"
  end
else
  Mongoid.config.master = Mongo::Connection.new.db("mongoid_auto_increment_test")
end
Mongoid.logger = Logger.new($stdout)

DatabaseCleaner.orm = "mongoid"

RSpec.configure do |config|
  config.before(:all) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end