$:.push File.expand_path(File.dirname(__FILE__)) #Ruby 1.9 took out current path from load path



def debug(board)
  board.each do |row|
    buffer = ""
    row.each do |point|
      buffer += "#{point}"
    end
    puts buffer
  end
end

def turn(player, client)
  move = player.next_move  
  response = client.fire(move)
  return if response.nil?
  if response["hit"] == true
    player.hit(move)
  else
    player.miss(move)
  end
  # p "#{client.user} #{move} - #{response['hit']}"
end

require 'lib/battleship_client'
config = YAML::load(File.open('config/battleship.yml'))

  @config = {
      :server => 'localhost', 
      :port => 3000,
    }
  client1 = BattleshipClient::Client.new(@config[:server], @config[:port], "player1")
  client2 = BattleshipClient::Client.new(@config[:server], @config[:port], "player2")

  client1.join_game
  client2.join_game

  player1 = BattleshipClient::Player.new
  player2 = BattleshipClient::Player.new

    while(client1.status == "playing" && client2.status == "playing") do
      if(client1.my_turn? == true)
        turn(player1, client1)
      else
        turn(player2, client2)
        # debug(player2.probability_board)
      end
      # sleep(0.3)
    end
    print "player #{client1.user} won" if client1.status == "won"
    print "player #{client2.user} won" if client2.status == "won"
  # p player2




