require 'active_record'

class PlayerSession < ActiveRecord::Base

# Associations

  belongs_to :server_session
  belongs_to :account
  belongs_to :user


# Validations

  validates_presence_of :server_session_id

end
