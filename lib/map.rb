require 'active_record'

class Map < ActiveRecord::Base

# Associations

  belongs_to :server


  def settings
    server.settings
  end

end
