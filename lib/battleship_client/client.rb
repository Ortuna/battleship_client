module BattleshipClient
  class Client
    attr_accessor :server, :port
    def initialize(server, port)
      @server, @port = server, port
    end

    def config(&block)
      instance_eval(&block)
    end
  end
end