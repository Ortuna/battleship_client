$:.push File.expand_path(File.dirname(__FILE__)) #Ruby 1.9 took out current path from load path
require 'lib/battleship_client'
config = YAML::load(File.open('config/battleship.yml'))

def turn_logic(player, client)
  move = player.next_move
  response = client.fire(move)
  return if response.nil?
  p "#{client.user} - #{move} - #{response['hit']? 'hit': 'miss'}"
  if response["hit"] == true
    player.hit(move)
  else
    player.miss(move)
  end
end

games = []
2.times do    
  game = {
          :client => BattleshipClient::Client.new(config["server"], config["port"], "player#{Random.rand(999)}"),
          :player => BattleshipClient::Player.new
        }
  game[:client].join_game
  games << game
end

while(games[0][:client].status == "playing" && games[1][:client].status == "playing") do
  games.each do |game|
    turn_logic(game[:player], game[:client]) if game[:client].my_turn?
  end
  sleep(0.3)
end

games.each do |game|
  puts "#{game[:client].user} #{game[:client].status}"
end






