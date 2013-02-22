require 'server_address'

class Server < ActiveRecord::Base

  States = {
    idle: 0,
    starting: 1,
    up: 2,
    stopping: 3
  }

  validates_presence_of :state

  # TODO Actuall embed Game
  def static_address?
    true
  end

  def state_name
    States.invert[state]
  end

  def address
    ServerAddress.new(self)
  end

end
