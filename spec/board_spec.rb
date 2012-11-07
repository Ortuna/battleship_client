require 'spec_helper'

describe BattleshipClient::Board do
  before :each do

  end

  it "Should generate a board" do
    BattleshipClient::Board.generate_board.should_not be_nil
  end

  
end