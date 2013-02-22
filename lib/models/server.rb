require 'server_address'

class Server < ActiveRecord::Base

  States = {
    idle: 0,
    starting: 1,
    up: 2,
    stopping: 3
  }


# Associations

  belongs_to :funpack
  belongs_to :creator, class_name: 'User'


# Validations

  validates_presence_of :state


# Other

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
