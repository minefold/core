require 'active_record'
require 'brock'
require 'friendly_id'
require 'json'

require 'core/games'

module Core
  class Funpack < ActiveRecord::Base
    extend FriendlyId

    # Associations

    # belongs_to :creator, class_name: 'User'
    #
    # scope :published, where('published_at is not ?', nil)
    #
    # attr_accessible :name, :game, :creator, :info_url, :description, :party_cloud_id, :imports, :slug, :game_id, :settings_schema, :published_at
    #
    # belongs_to :creator, class_name: 'User'
    #
    # friendly_id :name, :use => :slugged
    #
    # has_many :servers
    #
    # composed_of :game, mapping: [[:game_id, :id]],
    #                    constructor: ->(id){ GAMES.fetch(id) }
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
end
