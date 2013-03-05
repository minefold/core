require 'serializer'

class UserSerializer < Serializer

  attribute :id
  attribute :username
  attribute :created_at
  attribute :updated_at

end
