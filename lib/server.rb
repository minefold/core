require 'active_record'
require 'state_machine/core'
require 'paranoia'

require 'server_address'
require 'server_access_policies'

class Server < ActiveRecord::Base
  extend StateMachine::MacroMethods

  States = {
    down: 0,
    starting: 1,
    up: 2,
    stopping: 3,
    restarting: 4,
    crashed: 5
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

    event(:start) { transition([:down, :crashed] => :starting) }
    event(:started) { transition([:starting] => :up) }
    event(:restart) { transition([:up] => :restarting) }
    event(:restarted) { transition([:restarting] => :up)}
    event(:stop) { transition([:starting, :up] => :stopping) }
    event(:stopped) { transition([:up, :stopping] => :down) }

    before_transition all => :starting, :do => :start_party_cloud_server!
    before_transition all => :restarting, :do => :restart_party_cloud_server!
    before_transition all => :stopping, :do => :stop_party_cloud_server!

    before_transition all => :down, :do => :clear_ip_and_port
  end


  def start_party_cloud_server!
    PartyCloud.start_server!(
      party_cloud_id,
      attributes_for_party_cloud.to_json
    )
  end

  def restart_party_cloud_server!
    PartyCloud.restart_server!(
      party_cloud_id,
      attributes_for_party_cloud.to_json
    )
  end

  def stop_party_cloud_server!
    PartyCloud.stop_server!(party_cloud_id)
  end


  def clear_ip_and_port
    self.ip, self.port = nil, nil
  end

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
