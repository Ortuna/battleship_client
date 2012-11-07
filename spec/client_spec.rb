require 'spec_helper'

describe BattleshipClient::Client do

  before :each do
    @config = {
        :server => 'localhost', 
        :port => 3000,
        :user => 'Sumeetz'
      }
    @client = BattleshipClient::Client.new(@config[:server], @config[:port], @config[:user])
  end

  it "Should take server, port, user as a config option" do    
    client = BattleshipClient::Client.new(@config[:server], @config[:port], @config[:user])
    client.port.should == @config[:port]
    client.server.should == @config[:server]
    client.user.should == @config[:user]
  end

  it "Should start a new game with the status of playing" do
    @client.join_game
    @client.game_id.should_not be_nil
    @client.status.should == "playing"
  end

  it "Should return true of false for my_turn?" do
    @client.join_game
    @client.my_turn?.should_not be_nil    
  end

  it "Should be able to fire a shot" do
    @client.join_game
    response = @client.fire "e9"
    response.should_not be_nil
    response["hit"].should_not be_nil
  end
end