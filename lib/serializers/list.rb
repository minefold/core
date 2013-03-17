require 'serializer'

module Serializers
  class List < Serializer

    def data
      object.map do |obj|
        if obj.is_a?(Serializer)
          obj.payload
        else
          obj.as_json
        end
      end
    end

    def payload
      { object: 'list', count: object.length, data: data }
    end

  end
end
