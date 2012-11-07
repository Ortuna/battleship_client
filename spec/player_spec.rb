require 'spec_helper'

describe BattleshipClient::Player do
  before :each do
    @player = BattleshipClient::Player.new
  end

  it "Should keep a note of hits" do
    @player.hit "A9"
    @player.status("A9").should_not be_nil
    @player.status("A9").should == "h"
  end

  it "Should keep a note of a miss" do
    @player.miss "B9"
    @player.status("B9").should_not be_nil
    @player.status("B9").should == "m"
  end

  it "Should calculate the next move" do
    @player.hit "B5"
    move = @player.next_move
    move.should_not be_nil
  end

  it "debug" do
    puts ""    
    @player.miss "B9"
    @player.hit  "A9"
    @player.hit  "F5"
    @player.hit  "G5"
    @player.hit  "J1"
    @player.next_move
    board = @player.probability_board
    board.each do |row|
      buffer = ""
      row.each do |point|
        buffer += "#{point}"
      end
      puts buffer
    end
  end
end

