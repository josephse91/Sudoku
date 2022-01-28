class Player

    attr_accessor :tile_choice
    def initialize
        @name
    end
    #Position will be inputted through the command line by the user
    def pos_input
        pos = gets.chomp
        pos_arr = pos.split(",")
        new_arr = pos_arr.map {|ele| ele.to_i }
    end
    #Value will be inputted through the command line by the user
    def value_input
        pos = gets.chomp.to_i
    end
    #Will be used to select if the user will delete or add number from cell
    def action_input
        action = gets.chomp
    end

end