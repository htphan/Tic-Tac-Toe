require 'set'

class Cpu
  attr_reader :past_moves, :piece

  def initialize(piece)
    @piece = piece
    @past_moves = Set.new
  end

  # add_past_moves records the previous moves the cpu has taken
  # and places it into the @past_moves set to be used for win verification
  # in the game class.
  def add_past_moves(move)
    @past_moves.add(move)
  end

  def select_placement(available)
    @move = available.sample
    @move = @move - 1     # @move - 1 == the index that numbered block represents
  end
end