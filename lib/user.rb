require 'active_record'
require 'paranoia'
require 'friendly_id'
require 'uniquify'

# require 'core/concerns/authentication'
require 'concerns/coins'

class User < ActiveRecord::Base
  extend FriendlyId
  # include Core::Concerns::Authentication

# Associations

  belongs_to :invited_by, class_name: self.name
  has_many :bonuses
  has_many :created_servers,
    class_name: 'Server',
    foreign_key: 'creator_id'
  has_many :sessions, class_name: 'PlayerSession'

  has_and_belongs_to_many :watching,
    class_name: 'Server',
    join_table: 'watchers',
    uniq: true

  has_and_belongs_to_many :starred,
    class_name: 'Server',
    join_table: 'stars',
    uniq: true

  has_many(:accounts, :autosave => true)
  #  do
  #
  #   def mojang
  #     where(type: Accounts::Mojang)
  #   end
  #
  #   def facebook
  #     where(type: Accounts::Facebook)
  #   end
  #
  #   def steam
  #     where(type: Accounts::Steam)
  #   end
  #
  #   def linked?(type)
  #     where(type: type).exists?
  #   end
  #
  # end


# Validations

  validates_presence_of :username
  validates_presence_of :authentication_token
  validates_presence_of :invitation_token
  validates_presence_of :coins
  validates_uniqueness_of :username, allow_nil: false, allow_blank: false
  validates_numericality_of :coins, only_integer: true
  validates_numericality_of :balance, only_integer: true, allow_nil: true


# Other

  acts_as_paranoid
  friendly_id :username, use: :slugged
  uniquify :authentication_token, length: 24
  uniquify :invitation_token, length: 12
  uniquify :verification_token, length: 12

  # mount_uploader :avatar, AvatarUploader do
  #
  #   def store_dir
  #     File.join(model.class.name.downcase.pluralize, mounted_as.to_s, model.id.to_s)
  #   end
  #
  # end


  def minecraft_link_host
    "#{verification_token}.verify.minefold.com"
  end

  def invited?
    invited_by_id?
  end

  def channel_key
    [self.class.name.downcase, id.to_s].join('-')
  end

  def private_channel_key
    "private-#{channel_key}"
  end

# --

  before_create :generate_distinct_id

  def generate_distinct_id
    self.distinct_id ||= SecureRandom.uuid
  end

# --

  def customer?
    customer_id?
  end

  def played?
    sessions.any?
  end

  # TODO Doesn't order
  def last_played_at
    sessions.order_by(:started_at).reverse_order.pluck(:started_at).first
  end

end
