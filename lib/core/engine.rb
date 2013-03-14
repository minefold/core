require 'rails'

module Fold
  class Engine < Rails::Engine
    paths['app/models'] << File.expand_path('../models', __FILE__)
  end
end
