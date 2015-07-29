require 'set'

class Player
  attr_reader :past_moves, :piece

  def initialize(piece)
    @piece = piece
    @past_moves = Set.new
  end

  # add_past_moves records the previous moves the player has taken
  # and places it into the @past_moves set to be used for win verification
  # in the game class.
  def add_past_moves(move)
    @past_moves.add(move)
  end

  def select_placement(available)
    puts "Where would you like to move? (1-9)"
    @move = gets.chomp.to_i
    until available.include?(@move)
      puts "Your input was not recognized."
      puts "Please select a number between 1 and 9:"
      @move = gets.chomp.to_i
    end
    @move = @move - 1   # @move - 1 == the index that numbered block represents
  end
end