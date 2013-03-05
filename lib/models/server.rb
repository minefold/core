require 'active_record'
require 'state_machine/core'
require 'server_address'

class Server < ActiveRecord::Base
  extend StateMachine::MacroMethods

  States = {
    down: 0,
    starting: 1,
    up: 2,
    stopping: 3,
    crashed: 4
  }

  state_machine(:initial => :idle) do
    States.each {|name, value| state(name, value: value) }

    event(:start) { transition([:down, :starting, :crashed] => :starting) }
    event(:started) { transition([:starting] => :up) }
    event(:stop) { transition([:starting, :up] => :down) }

    before_transition all => :down,
      :do => :clear_ip_and_port
  end


# Associations

  belongs_to :funpack
  belongs_to :creator, class_name: 'User'


# Validations

  validates_presence_of :state


# Other

  serialize :settings, JSON


  def static_address?
    false
  end

  # TODO Actuall embed Game
  def dynamic_ip?
    false
  end

  def address
    ServerAddress.new(self)
  end

  def clear_ip_and_port
  end

end
