require 'serializer'

module Serializers
  class ServerAddressSerializer < Serializer

    def as_json
      {
        cname: object.url,
        ip: object.ip,
        port: object.port
      }
    end

  end
end
