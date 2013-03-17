require 'serializer'
require 'ipaddr'

module Serializers
  class Server < Serializer

    def payload
      o = super

      o[:name] = object.name

      o[:creatorId] = object.creator_id.to_s
      o[:creatorUrl] = "https://api.minefold.com/users/#{object.creator_id}"

      o[:funpackId] = object.funpack_id.to_s

      o[:created] = object.created_at
      o[:updated] = object.updated_at

      o[:url] = "https://api.minefold.com/servers/#{object.id}"

      o[:state] = object.state_name
      o[:gameplay] = object.settings

      o[:access] = object.access_policy.name

      o[:players] = object.players.count

      if object.up?
        o[:ip] = object.ip
        o[:port] = object.port
      end

      o
    end

  end
end
