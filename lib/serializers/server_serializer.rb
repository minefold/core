class ServerSerializer < ActiveModel::Serializer
  root false

  attributes :id,
    :name,
    :state,
    :address,
    :splitBilling,
    :createdAt,
    :updatedAt,
    :players

  def address
    object.address.to_s
  end

  def state
    object.state_name
  end

  def partyCloudId; object.party_cloud_id end
  def splitBilling; object.shared? end
  def createdAt; object.created_at end
  def updatedAt; object.updated_at end

  def players
    $redis.smembers("servers:#{object.party_cloud_id}:players")
  end

end
