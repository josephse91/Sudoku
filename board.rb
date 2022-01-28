require "./tile.rb"

class Board

    attr_accessor :grid
    #Upon initialization, a 2D board will be generated with new Tiles.
    def initialize
        @grid = Array.new(9) { Array.new(9) { Tile.new }}
    end
    
    #Board getter
    def [](pos)
        @grid[pos]
    end
    
    #Board setter
    def []=(pos,value)
       @grid[pos] = value
    end
    
    #takes input from text file to create the board. These can be found the directory
    def from_file(file_name)
        s_board = File.open(file_name)
        play_board = s_board.readlines.map(&:chomp)

        play_board.each_with_index do |line,idx1| 
            line.each_char.with_index do |char, idx2| 
                number = char.to_i
                @grid[idx1][idx2].set_value(number)
                @grid[idx1][idx2].inputter = true if number == 0 
            end
        end
    end
    
    #Place the user input number using the position and value
    def number_input(position,value)
        x,y = position
        self[x][y].set_value(value)
    end
    
    #Delete the number within the cell at the designated position 
    def number_remove(position)
        x,y = position
        self[x][y].set_value(0)
    end
    
    #Delete the number within the cell at the designated position 
    def quit
        self.win? == true
    end
    
    #Define how to win the game
    def win?
        return true if (self.win_row? && self.win_col? && self.win_box?)
        false
    end
    
    #Define successfully solved row
    def win_row?
        @grid.each do |row| 
            return false if self.uniq_tiles(row).length != 9
        end
        true
    end
    
    #Define successfully solved column
    def win_col?
        sudo_grid = @grid.transpose
        sudo_grid.each do |col| 
            return false if self.uniq_tiles(col).length != 9
        end
        true
    end

    #Define successfully solved box
    def win_box?
        boxes = self.make_boxes
        boxes.each_with_index do |row, row_i|
            row.each_with_index do |box, col_i|
                box.delete(0)
                return false if box.uniq.length != 9
            end
        end
        true
    end
    
    #helper functions to be able to interate through a box and see if it is successfully solved.
    def make_boxes
        boxes = Array.new(3) {Array.new(3) {[]}}
        @grid.each_with_index do |row, row_i|
            row.each_with_index do |cell, col_i|
                box_x = self.box_sorter(row_i)
                box_y = self.box_sorter(col_i)
                boxes[box_x][box_y] << cell.value 
            end
        end
        boxes
    end

    #helper functions to be able to interate through a box
    def box_sorter(input)
        x = input
        case 
            when x <= 2 
                row = 0
            when (x >= 3 && x <= 5) 
                row = 1
            when (x >= 6 && x <= 8) 
                row = 2
        end
        row
    end

    def print_game
        system("clear")
        self.print_header
        @grid.each_with_index do |row, row_i|
            row.each_with_index do |tile, col_i|
                self.print_tile_values(tile)
                self.game_lines(col_i)
            end
            print "\n"
            if (row_i + 1) % 3 == 0
                p "-".ljust(20,"-")
            end
        end
        return
    end

    #more helper functions

    def valid_tile(pos)
        x,y = pos
        return false if (x > @grid.count || y > @grid.count)
        true
    end

    def valid_char(num)
        return false if num.is_a?(Integer) != false
        true
    end

    def uniq_tiles(array)
        new_arr = array.select {|ele| ele.value > 0 }
        new_arr.uniq 
    end

    def valid_user_spot(pos)
        x,y = pos
        return false if self[x][y].inputter == false
        true
    end

    
    #printing helper functions
    def game_lines(col)
        if (col + 1) % 3 == 0
            print "|"
        end
    end

    def print_tile_values(tile)
        if tile.value == 0
            print "".rjust(2)
        else
            print tile.value.to_s.rjust(2)
        end
    end

    def print_header
        p "-".ljust(20,"-")
        p "PLAY SUDOKU".center(20)
        p "-".ljust(20,"-")
    end

end