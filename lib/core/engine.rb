require 'rails'

module Core
  class Engine < Rails::Engine
    paths['app/models'] << File.expand_path('../models', __FILE__)
  end
end
