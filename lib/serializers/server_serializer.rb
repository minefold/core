require 'player'
require 'serializers/funpack_serializer'
require 'serializers/player_serializer'
require 'serializers/user_serializer'

class ServerSerializer < ActiveModel::Serializer
  root false

  attributes :id,
    :name,
    :state,
    :address,
    :party_cloud_id

  attribute :state_name, :key => :state
  attribute :shared?, :key => :splitBilling
  attribute :created_at, :key => :createdAt
  attribute :updated_at, :key => :updatedAt

  has_one :creator, serializer: UserSerializer
  has_one :funpack, serializer: FunpackSerializer

  has_many :players, serializer: PlayerSerializer

  def address
    object.address.to_s
  end

  def players
    options[:redis].smembers("servers:#{object.party_cloud_id}:players").map do |nick|
      Player.new(nick)
    end
  end

end
