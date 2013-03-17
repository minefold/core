require 'active_record'
require 'state_machine/core'
require 'paranoia'

require 'server_address'
require 'server_access_policies'

class Server < ActiveRecord::Base
  extend StateMachine::MacroMethods

  States = {
    down: 0,
    up: 1,
    crashed: 2
  }


# Associations

  belongs_to :funpack
  belongs_to :creator, class_name: 'User', :inverse_of => :created_servers
  has_many :snapshots, :dependent => :destroy
  has_many :maps, :dependent => :destroy
  has_many :posts, order: 'created_at DESC', :dependent => :destroy

  # TODO Remove
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
    def active
      where(ended_at: nil)
    end
  end

  has_many :players, :class_name => 'PlayerSession' do
    def active
      where(ended_at: nil)
    end
  end


# Validations

  validates_presence_of :name
  validates_presence_of :state
  validates_presence_of :party_cloud_id
  validates_presence_of :funpack_id
  validates_presence_of :creator_id


# Other

  acts_as_paranoid
  serialize :settings, JSON
  delegate :game, :to => :funpack

  state_machine(:initial => :idle) do
    States.each {|name, value| state(name, value: value) }

    event(:start) { transition([:down, :up] => :up) }
    event(:stop) { transition([:up, :down] => :down) }
  end

  def current_session
    sessions.active.first
  end

  delegate :ip,   :to => :current_session
  delegate :port, :to => :current_session

# --

  def attributes_for_party_cloud
    { name: name,
      access: {
        access_policy.name => access_policy.data
      },
      settings: settings
    }
  end

  def access_policy
    @access_policy ||= ServerAccessPolicies::Whitelist.new(self)
  end

end
