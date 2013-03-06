require 'serializer'

class UserSerializer < Serializer

  attribute :id
  attribute :username
  attribute :created_at
  attribute :updated_at

  def as_json
    json = super
    json[:url] = "https://api.minefold.com/users/#{user.id}"
    json
  end

end
