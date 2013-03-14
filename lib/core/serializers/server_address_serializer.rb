require 'core/serializer'

module Core
  module Serializers
    class ServerAddressSerializer < Core::Serializer

      def as_json
        {
          cname: object.url,
          ip: object.ip,
          port: object.port
        }
      end

    end
  end
end
