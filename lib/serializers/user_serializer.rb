require 'serializer'

module Serializers
  class UserSerializer < Core::Serializer

    attribute :id
    attribute :username

    def as_json
      json = super
      json[:url] = "https://api.minefold.com/users/#{object.id}"

      json[:created] = object.created_at
      json[:updated] = object.updated_at

      json
    end

  end
end
