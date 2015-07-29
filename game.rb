require 'pry'
require 'set'
require './board'
require './player'
require './cpu'

class Game
  attr_reader :board, :win_combos, :player1, :player2, :move
  def initialize
    # @score = [] to implement the score in another file
    @board = Board.new
    @win_combos = @board.win_combos
  end

  def playing_mode
    puts "Let's play Tic Tac Toe!"
    puts "**Playing Modes**"
    puts "1: Player1 vs CPU"
    puts "2: Player1 vs Player2"
    puts "3: CPU vs CPU"
    puts "Please select your playing mode (1, 2, or 3):"
    p_mode = gets.chomp
    until p_mode =~ /^[1-3]$/
      puts "Your input was not recognized."
      puts "Please select 1, 2, or 3:"
      p_mode = gets.chomp
    end
    if p_mode == "1"
      piece = choose_piece
      @player1 = Player.new(piece)
      avail_piece = ["X", "O"].reject { |x| x == piece}
      @player2 = Cpu.new(avail_piece[0])
    elsif p_mode == "2"
      piece = choose_piece
      @player1 = Player.new(piece)
      avail_piece = ["X", "O"].reject { |x| x == piece}
      @player2 = Player.new(avail_piece[0])
    else
      @player1 = Cpu.new("X")
      @player2 = Cpu.new("O")
    end 
    p_mode  
  end

  def start
    random_player = [@player1, @player2].sample
    @current_player = random_player
    puts "Welcome to Multiplayer Mode!"
    puts "To choose your placements, input the corresponding"\
      "\nnumber with your desired placement!"\
      "\n(ex: 1 for the top left corner)"
    gameplay
  end

  def gameplay
    until complete?
      @board.show_board     
      puts "It's #{@current_player.piece}'s turn!"
      @move = choose_move(@current_player)
      @board.replace_block(@move, @current_player.piece)
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
    @board.show_board 
    if win? 
      find_winner
    else
      puts "It's a draw!"
    end
  end

  def win?
    @p1_win = @win_combos.map do |x|
      x.to_set.subset?(@player1.past_moves)
    end
    @p2_win = @win_combos.map do |x|
      x.to_set.subset?(@player2.past_moves)
    end
    @p1_win.include?(true) || @p2_win.include?(true)
  end

  def find_winner
    if @p1_win.include?(true)
      if @player1.class == Player 
        puts "Player1('#{@player1.piece}') is the Winner!"
      else
        puts "The CPU('#{@player1.piece}') is the Winner!"
      end
    else
      if @player2.class == Cpu && @player1.class == Player
        puts "You Lost! The CPU('#{@player2.piece}') beat you!"
      elsif @player2.class == Player
        puts "Player2('#{@player2.piece}') is the Winner!"
      else
        puts "The CPU('#{@player2.piece}') is the Winner!"
      end
    end
  end

  def draw?
    @board.board.all? { |x| x.is_a? String }
  end

  def complete?
    win? || draw?
  end

  def choose_move(player)
    @available = @board.available_blocks
    @move = player.select_placement(@available)
    until @available.include?(@move+1)
      puts "Your input was not recognized, please try again:"
      @move = player.select_placement(@available)
    end
    player.add_past_moves(@move)
    @move
  end

  def choose_piece
    puts "Player 1: What piece would you like to be? (X or O)"
    piece = gets.chomp.upcase 
    until piece =~ /^[xo]$/i
      puts "Your input was not recognized."
      puts "Please select 'X' or 'O':" 
      piece = gets.chomp.upcase
    end
    piece
  end
end

