module Core
  class Player

    attr_reader :nick
    attr_reader :account

    def initialize(params)
      @nick = params.fetch(:nick)
      @account = params[:account]
    end

  end
end
