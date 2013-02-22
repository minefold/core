# encoding: utf-8
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'minefold/version'

Gem::Specification.new do |gem|

  gem.name    = 'minefold-core'
  gem.version = Minefold::VERSION
  gem.author  = 'Chris Lloyd'
  gem.email   = 'christopher.lloyd@gmail.com'

  gem.require_paths = ['lib']

  gem.add_dependency 'activerecord', '~> 3.2'
  gem.add_dependency 'active_model_serializers'
  gem.add_development_dependency 'rspec'

  gem.files = %w( Gemfile README.md minefold-core.gemspec ) +
    Dir['{lib,spec}/**/*']
  gem.test_files  = gem.files.grep(/^spec\//)

end
