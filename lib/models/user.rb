require 'active_record'
require 'paranoia'
require 'friendly_id'

class User < ActiveRecord::Base
  extend FriendlyId
  acts_as_paranoid
  friendly_id :username, use: :slugged
  has_many :created_servers, class_name: 'Server', foreign_key: 'creator_id'
end
