module BattleshipClient
  class Board
    def self.generate_board

      #generating a 10x10 board
      board = []
      (1..10).to_a.each do 
        row = []
        (1..10).to_a.each do
          row << ""
        end
        board << row
      end

      #placing ships 2..5 range

      [2,3,3,4,5].to_a.each do |i|
        loop do
          orientation = Random.rand(2) # 0 = - , 1 = |
          x = Random.rand(10)
          y = Random.rand(10)

          #if this piece is too big to fit, lets shift 
          #it back some
          if orientation == 0 && x-i < 0
            x = (x+i)
          end
          if orientation == 1 && y-i < 0
            y = (y+i)
          end

          #collision detection with other units
          find_new_spot = false
          (1..i).to_a.each do |j|
            if orientation == 1 && board[x][y-j] != ""
              find_new_spot = true
            elsif orientation == 0 && board[x-j][y] != ""
              find_new_spot = true
            end
          end

          #Try to find a new spot because of collision
          redo if find_new_spot

          #Plot in the array
          (1..i).to_a.each do |j|
            if orientation == 1 
              board[x][y-j] = "#{i}"
            else
              board[x-j][y] = "#{i}"
            end
          end
          break
        end
      end
      board
    end
  end
end