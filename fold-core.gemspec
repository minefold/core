# encoding: utf-8
$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'core/version'

Gem::Specification.new do |gem|
  gem.name        = 'fold-core'
  gem.version     = Core::VERSION
  gem.author      = 'Chris Lloyd'
  gem.email       = 'christopher.lloyd@gmail.com'
  gem.homepage    = 'https://github.com/minefold/core'
  gem.summary     = 'Core'
  gem.description = 'Fold Core'

  gem.require_paths = ['lib']

  gem.add_dependency 'activerecord', '~> 3.2'
  gem.add_dependency 'activesupport', '~> 3.2'
  gem.add_dependency 'state_machine'
  gem.add_dependency 'paranoia'
  gem.add_dependency 'friendly_id'
  gem.add_dependency 'brock'
  gem.add_dependency 'uniquify'
  gem.add_dependency 'devise'
  gem.add_development_dependency 'rspec'

  gem.files = %w( Gemfile README.md fold-core.gemspec ) +
    Dir['{app,db,lib,spec}/**/*']
  gem.test_files  = gem.files.grep(/^spec\//)

end
