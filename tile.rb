class Tile

    attr_accessor :inputter
    attr_reader :value
    #The initialized function will set a tile to be 0 which is a blank.
    #The @inputter signifies if the board initial provided a number
    def initialize
        @value = 0
        @inputter = false

    end

    def set_value(value)
        @value = value
    end
    
    def empty?
        @value == 0 || @value == ""
    end
    #Check if input was by user or board
    def user_input?(tile)
        @inputter == true
    end

end