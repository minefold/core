module Core

  def self.redis=(redis)
    @redis = redis
  end

  # TODO raise Error
  def self.redis
    @redis
  end

end
