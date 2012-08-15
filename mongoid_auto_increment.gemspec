# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid_auto_increment/version'

Gem::Specification.new do |gem|
  gem.name          = 'mongoid_auto_increment'
  gem.version       = MongoidAutoIncrement::VERSION
  gem.authors       = ["Peter Savichev (proton)"]
  gem.email         = ["psavichev@gmail.com"]
  gem.description   = %q{Add SQL like auto-incrementing fields to your Mongoid documents.}
  gem.summary       = %q{Auto-incrementing fields for Mongoid documents}
  gem.homepage      = "https://github.com/proton/mongoid_auto_increment"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'mongoid'
end
