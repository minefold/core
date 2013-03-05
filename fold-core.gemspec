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
  gem.add_dependency 'state_machine', '~> 1.1'
  gem.add_dependency 'paranoia', '~> 1.2'
  gem.add_dependency 'friendly_id', '~> 4.0'
  gem.add_development_dependency 'rspec'

  gem.files = %w( Gemfile README.md fold-core.gemspec ) +
    Dir['{db,lib,spec}/**/*']
  gem.test_files  = gem.files.grep(/^spec\//)

end
