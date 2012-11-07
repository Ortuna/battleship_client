module BattleshipClient
  class Player
    attr_accessor :board
    def initialize
      board = []
      (1..10).to_a.each do 
        row = []
        (1..10).to_a.each do
          row << "."
        end
        board << row
      end
      @board = board
    end

    def hit(coords)
      update_status coords, "h"
    end    

    def miss(coords)
      update_status coords, "m"
    end

    def status(coords)
      x,y = coords_to_point(coords)
      @board[x][y]
    end

    private 
    def update_status(coords, status)
      x,y = coords_to_point(coords)
      @board[x][y] = status
    end

    def coords_to_point(coords)
      coords = coords.downcase
      x = 1
      coords[0].each_byte do |byte|
        x = byte - 96 #starting at a = 97
      end
      y = (coords[1]).to_i-1
      return x,y
    end
  end
end