module BattleshipClient
  class Client
    attr_accessor :server, :port
    def initialize(server, port)
      @server, @port = server, port
    end
  end
end