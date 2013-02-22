class Player

  attr_reader :nick

  def initialize(nick)
    @nick = nick
  end

  alias_method :read_attribute_for_serialization, :send

end
