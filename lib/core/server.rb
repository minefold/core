require 'active_record'
require 'state_machine/core'
require 'paranoia'
require 'core/server_address'

module Core
  class Server < ActiveRecord::Base
    extend StateMachine::MacroMethods
    acts_as_paranoid

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
    belongs_to :creator, class_name: 'User', :inverse_of => :created_servers
    has_many :posts, order: 'created_at DESC', :dependent => :destroy
    has_one :world, order: 'updated_at ASC', :dependent => :destroy

    has_and_belongs_to_many :watchers,
      class_name: 'User',
      join_table: 'watchers',
      uniq: true

    has_and_belongs_to_many :starrers,
      class_name: 'User',
      join_table: 'stars',
      uniq: true

    has_many :sessions, :class_name => 'ServerSession' do
      def current
        active.first_or_initialize
      end

      def current?
        active.exists?
      end
    end


  # Validations

    validates_presence_of :name
    validates_presence_of :state
    validates_presence_of :party_cloud_id
    validates_presence_of :funpack_id


  # Other

    serialize :settings, JSON
    delegate :game, :to => :funpack

    def clear_ip_and_port
      self.ip, self.port = nil, nil
    end

  end
end
