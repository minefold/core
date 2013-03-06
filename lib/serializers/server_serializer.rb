require 'serializer'
require 'ipaddr'

class ServerSerializer < Serializer

  attribute :id
  attribute :name
  attribute :creator_id
  attribute :funpack_id
  attribute :created_at
  attribute :updated_at

  def as_json
    json = super

    json[:state] = object.state_name
    json[:settings] = object.settings

    if object.cname?
      json[:server_url] = object.cname
    elsif object.static_address?
      json[:server_url] =  "#{object.id}.fun-#{object.funpack_id}.us-east-1.foldserver.com"
    end

    if object.up?
      if object.host !=~ /(minefold|foldserver)\.com$/
        json[:ip] = object.host
      end
      json[:port] = object.port
    end

    json
  end

end
