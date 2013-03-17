require 'active_support/core_ext/string/inflections'

class ServerAccessPolicy

  attr_reader :server

  def initialize(server)
    @server = server
  end

  def name
    self.class.name.demodulize.downcase.to_sym
  end

  def data
    nil
  end

end
