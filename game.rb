require "./board.rb"
require "./player.rb"

class Game
    #The game will begin by initializing a board and a player
    def initialize
        @board = Board.new
        @player = Player.new
    end

    #Allows the user to pick the sudoku text file to import from the directory
    def board_prep
        p "Enter the Sudoku file name"
        puts
        file_name = @player.action_input
        @board.from_file(file_name)
        @board.print_game
    end

    #Prompts to receive and validate position of user inputs
    def pick_pos
        p "Please enter the number of the cell that you would like to place value"
        cell = @player.pos_input
        
        if cell.is_a?(Array) == false
            p "This is entry is not valid. Please reenter value"
            self.pick_pos
        end
        x,y = cell
                
        if @board.valid_tile([x,y]) == false
            p "This position is not available to be changed"
            self.pick_pos
        end

        if @board.valid_user_spot([x,y]) == false
            p "This position was given with the board"
            self.pick_pos
        end
        [x,y]
    end
    
    #Prompts to receive and validate value of user inputs
    def place_value(pos)
        x,y = pos
        p "Enter value at cell at position #{x}, #{y}"
        value = @player.value_input
        
        if @board.valid_char(pos) == false
            p "This is entry is not valid. Please reenter value"
            place_value(pos)
        end
        @board.number_input(pos,value)    
    end

    #Action once the user has inputted their pos and value in the command
    def player_action
        p "Enter a command"
        p " a: add number; d: delete number"
        action = @player.action_input
        case 
        when action = "a"
            pos = self.pick_pos
            self.place_value(pos)
        when action = "d"
            pos = self.pick_pos
            @board.number_remove(pos)
        when action = "q"
            p "You have quit the game"
            @board.quit
            return
        else
            p "Provide valid action"
            self.player_action
        end
    end
    
    #Runs the sudoku game
    def play
        self.board_prep
        until @board.win?
            self.player_action
            system("clear")
            @board.print_game
        end
        p "You win!!"
    end

end