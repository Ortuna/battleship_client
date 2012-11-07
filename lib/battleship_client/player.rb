module BattleshipClient
  class Player
    attr_accessor :board, :probability_board

    def initialize
      board = []
      (1..10).to_a.each do 
        row = []
        (1..10).to_a.each do
          row << 0
        end
        board << row
      end
      @board = board
      @probability_board = @board
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

    def next_move
      calculate_probability
      move = find_next_move

      return point_to_coord(move[:x],move[:y]) unless move[:value] == 0
      return point_to_coord(Math.rand(10),Math.rand(10)) #random fire
    end

    private

    def find_next_move
      target = {x: nil, y: nil, value: 0}
      (0..10).to_a.each do |y|
        (0..10).to_a.each do |x|
          value = get_probability(x,y)
          if value.class == Fixnum && value > target[:value]
            target[:x],target[:y],target[:value] = x,y, get_probability(x,y)
          end
        end
      end
      target
    end
    def calculate_probability
      #find hits
      (0..10).to_a.each do |y|
        (0..10).to_a.each do |x|
          value = get_probability x,y
          update_miss_probability(x,y) if value == "m"
          update_hit_probability(x,y) if value == "h"          
        end
      end      
    end

    def update_hit_probability(x,y)
      set_probability(x+1,y,3)
      set_probability(x-1,y,3)
      set_probability(x,y+1,3)
      set_probability(x,y-1,3)

      set_probability(x+2,y,2)
      set_probability(x-2,y,2)
      set_probability(x,y+2,2)
      set_probability(x,y-2,2)


      set_probability(x+3,y,1)
      set_probability(x-3,y,1)
      set_probability(x,y+3,1)
      set_probability(x,y-3,1)
    end


    def update_miss_probability(x,y)
      set_probability(x+1,y,-1)
      set_probability(x-1,y,-1)
      set_probability(x,y+1,-1)
      set_probability(x,y-1,-1)
    end

    def get_probability(x,y)
      return nil if out_of_bounds?(x,y)
      @probability_board[x][y]
    end

    def set_probability(x,y, value)
      return nil if out_of_bounds?(x,y) || @probability_board[x][y].class != Fixnum
      @probability_board[x][y] += value if @probability_board[x][y]+value > 0
    end

    def out_of_bounds?(x, y)
      return true if x >= 10 || x < 0 || y >= 10 || y < 0 # out of grid
      return false
    end

    def update_status(coords, status)
      x,y = coords_to_point(coords)
      @board[x][y] = status
    end

    def coords_to_point(coords)
      coords = coords.downcase
      y = coords[0].ord - 97
      x = (coords[1]).to_i-1
      return x,y
    end

    def point_to_coord(x,y)
      "#{(x+97).chr.upcase}#{y}"
    end
  end
end