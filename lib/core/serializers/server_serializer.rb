require 'core/serializer'
require 'ipaddr'

module Core
  module Serializers
    class ServerSerializer < Core::Serializer

      def as_json
        json = super

        json[:id] = object.id.to_s
        json[:name] = object.name

        json[:creatorId] = object.creator_id.to_s
        json[:creatorUrl] = "https://api.minefold.com/users/#{object.creator_id}"

        json[:funpackId] = object.funpack_id.to_s

        json[:created] = object.created_at
        json[:updated] = object.updated_at

        json[:url] = "https://api.minefold.com/servers/#{object.id}"

        json[:state] = object.state_name
        json[:settings] = object.settings

        if object.cname?
          json[:serverUrl] = object.cname
        elsif object.static_address?
          json[:serverUrl] =  "#{object.id}.fun-#{object.funpack_id}.us-east-1.foldserver.com"
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
  end
end
