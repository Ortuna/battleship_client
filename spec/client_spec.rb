require 'spec_helper'

describe BattleshipClient::Client do

  before :each do
    @config = {
        :server => 'localhost', 
        :port => 3000,
        :user => 'Sumeet'
      }
  end

  it "Should take server, port, user as a config option" do    
    client = BattleshipClient::Client.new(@config[:server], @config[:port], @config[:user])
    client.port.should == @config[:port]
    client.server.should == @config[:server]
    client.user.should == @config[:user]
  end

  it "Should start a new game" do

  end
end