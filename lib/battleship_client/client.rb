module BattleshipClient
  class Client
    attr_accessor :server, :port, :user
    def initialize(server, port, user)
      @server, @port, @user = server, port, user
    end
  end
end