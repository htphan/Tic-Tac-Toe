require 'minitest/autorun'
require './game'
require './cpu'
require './player'
require './board'

class CpuTest < MiniTest::Test
  def test_cpu_has_piece
    cpu = Cpu.new("X")
    assert cpu.piece == "X"
  end

  def test_cpu_guess
    available_index = (0..8).to_a    
    cpu = Cpu.new("X") 
    guess = cpu.select_placement(available_index)
    assert available_index.include?(guess)
  end
end

class PlayerTest < MiniTest::Test
  def test_player_has_piece
    player = Player.new("X")
    assert player.piece == "X"
  end

  def test_player_can_guess
    available_index = (0..8).to_a
    player = Player.new("X")
    guess = player.select_placement(available_index)
    assert available_index.include?(guess)
  end
end

class BoardTest < MiniTest::Test
  def test_can_make_board
    board = Board.new
    assert_instance_of Board, board
  end

  def test_can_show_board
    board = Board.new
    show_board = board.show_board
    assert_instance_of Array, show_board
  end
end

class GameTest < MiniTest::Test
  def test_can_start_game
    test_game = Game.new
    assert_instance_of Game, test_game
  end

  def test_can_get_playing_mode
    test_game = Game.new
    p_mode = test_game.playing_mode
    assert [1,2,3].include?(p_mode.to_i)
  end

  def test_can_complete_game
    test_game = Game.new
    test_game.playing_mode
    test_game.start
    complete = test_game.gameplay
    assert complete == nil
  end
end
