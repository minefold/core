require 'active_record'

class ServerSession < ActiveRecord::Base

# Associations

  belongs_to :server
  belongs_to :user
  has_many :player_sessions


# Validations

  validates_presence_of :server_id
  validates_presence_of :user_id

end
