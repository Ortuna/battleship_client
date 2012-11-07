require 'spec_helper'

describe BattleshipClient::Client do

  before :each do
    @config = {:server => 'localhost', :port => 3000}
  end
  
  it "Should take server & port as a config option" do
    
    client = BattleshipClient::Client.new(@config[:server], @config[:port])
    client.port.should == @config[:port]
    client.server.should == @config[:server]
  end

  it "Should start a new game" do

  end
end