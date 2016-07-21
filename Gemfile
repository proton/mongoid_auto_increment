source 'https://rubygems.org'

# Specify your gem's dependencies in mongoid_auto_increment.gemspec

case version = ENV['MONGOID_VERSION'] || '~> 5.0'                                                                
when /5/                                                                                                         
  gem 'mongoid', '~> 5.0'                                                                                        
when /4/                                                                                                         
  gem 'mongoid', '~> 4.0'                                                                                        
when /3/                                                                                                         
  gem 'mongoid', '~> 3.0'                                                                                     
else                                                                                                             
  gem 'mongoid', '~> 2.0'                                                                                         
end       

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem 'bundler'
  gem 'jeweler', '~> 1.8.6'
  gem 'rake'
  gem 'rdoc'
  gem 'rspec', '>= 2.0.0'
  gem 'simplecov', '>= 0.4.0', require: false
  gem 'database_cleaner', '>= 0.8.0'
end
