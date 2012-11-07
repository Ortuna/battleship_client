module BattleshipClient
  class Client
    attr_accessor :server, :port, :user, :game_id

    def initialize(server, port, user)
      @server, @port, @user = server, port, user
      @game_id = nil
    end

    def join_game
      params = {user: @user, board: generate_board}      
      response = post "games/join", params
      body = json_parse(response)
      @game_id = body["game_id"]
    end

    def status
      game_status["game_status"]
    end

    def my_turn?
      game_status["my_turn"]
    end

    def fire(coords)
      params = {user: @user, game_id: @game_id, shot: coords}
      response = post "games/fire", params
      json_parse(response)
    end

    private    
    def game_status      
      params   = {game_id: @game_id, user: @user}
      response = get "games/status", params
      json_parse(response)
    end

    def json_parse(response)
      return nil if response.code != 200
      JSON.parse(response.body)
    end

    def post(uri, params)
      options = {body: params}
      HTTParty.post create_url(uri), options
    end

    def get(uri, params)
      options = {body: params}
      HTTParty.get create_url(uri), options
    end

    def create_url(uri)
      "http://#{@server}:#{@port}/#{uri}"
    end

    def generate_board
      BattleshipClient::Board.generate_board.to_s
    end
  end
end