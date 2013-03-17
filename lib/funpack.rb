require 'active_record'
require 'brock'
require 'friendly_id'
require 'json'

class Funpack < ActiveRecord::Base
  extend FriendlyId

# Associations

  belongs_to :creator, class_name: 'User'
  has_many :servers


# Validations

  validates_presence_of :name
  validates_presence_of :creator


# Other



  # scope :published, where('published_at is not ?', nil)
  #

  #
  # friendly_id :name, :use => :slugged
  #
  #
  #
  # composed_of :game, mapping: [[:game_id, :id]],
  #                    constructor: ->(id){ Core::GAMES.fetch(id) }
  #
  # serialize :settings_schema, JSON
  #
  # def settings
  #   Brock::Schema.new(settings_schema)
  # end
  #
  # def published?
  #   !published_at.nil?
  # end

end
