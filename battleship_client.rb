$:.push File.expand_path(File.dirname(__FILE__)) #Ruby 1.9 took out current path from load path

require 'lib/battleship_client'
config = YAML::load(File.open('config/battleship.yml'))

client = BattleshipClient::Client.new(config["server"], config["port"])


p client.server
