require 'active_record'
require 'paranoia'
require 'friendly_id'
require 'uniquify'

require 'core/concerns/authentication'
require 'core/concerns/coins'

module Core
  class User < ActiveRecord::Base
    extend FriendlyId

    acts_as_paranoid
    friendly_id :username, use: :slugged

  # Associations

    belongs_to :invited_by, class_name: self.name
    has_many :bonuses
    has_many :created_servers, class_name: 'Server', foreign_key: 'creator_id'

    has_and_belongs_to_many :watching,
      class_name: 'Server',
      join_table: 'watchers',
      uniq: true

    has_and_belongs_to_many :starred,
      class_name: 'Server',
      join_table: 'stars',
      uniq: true

    has_many(:accounts, :autosave => true) do

      def mojang
        where(type: Accounts::Mojang)
      end

      def facebook
        where(type: Accounts::Facebook)
      end

      def steam
        where(type: Accounts::Steam)
      end

      def linked?(type)
        where(type: type).exists?
      end

    end


  # Validations

    validates_presence_of :username
    validates_uniqueness_of :username, :allow_nil => false, :allow_blank => false

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
      accounts.includes(:sessions).any?
    end

    def last_played_at
      session = PlayerSession
        .joins(:account => :user)
        .where(users: {id: self.id})
        .first

      if session
        session.started_at
      else
        nil
      end
    end

  end
end
