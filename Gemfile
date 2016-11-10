source 'https://rubygems.org'

# Specify your gem's dependencies in mongoid_auto_increment.gemspec

version = case ENV['MONGOID_VERSION']
          when /6/ then '~> 6.0'
          when /5/ then '~> 5.0'
          when /4/ then '~> 4.0'
          when /3/ then '~> 3.0'
          else
            '~> 2.0'
          end

gem 'mongoid', version

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem 'bundler'
  gem 'jeweler', '~> 1.8.6'
  gem 'rake'
  gem 'rack', '~> 1.6.4'
  gem 'rdoc'
  gem 'rspec', '>= 2.0.0'
  gem 'simplecov', '>= 0.4.0', require: false
  gem 'database_cleaner', '>= 0.8.0'
end
