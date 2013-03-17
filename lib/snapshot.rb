require 'active_record'

class Snapshot < ActiveRecord::Base

# Associations

  belongs_to :server


# Validations

  validates_presence_of :server_id
  validates_presence_of :party_cloud_id

end
