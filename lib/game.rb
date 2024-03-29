require 'active_support/core_ext/numeric/time'

class Game

  # Required
  attr_reader :id
  attr_reader :name
  attr_reader :slug

  attr_reader :funpack_id
  attr_reader :published_at
  attr_reader :url

  def initialize(params)
    @id = params.fetch(:id)
    @name = params.fetch(:name)
    @slug = params.fetch(:slug)

    @funpack_id = params[:funpack_id]
    @published_at = params[:published_at]
    @url = params[:url]
  end

  def auth?
    false
  end

  def split_billing?
    false
  end

  def static_address?
    false
  end

  def mappable?
    false
  end

  def new?
    published_at >= 2.months.ago
  end

  def published?
    !(funpack_id.nil? or published_at.nil?)
  end

  def to_param
    slug
  end

end
