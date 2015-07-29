require 'pry'

class Board

  attr_reader :n, :board, :rows, :columns, :diagonals, :win_combos

  def initialize
    @n = get_size
    @board = (1..@n**2).to_a
    @rows = get_rows
    @columns = get_columns
    @diagonals = get_diagonals
    @win_combos = win_combos
    @max_length = @board.max.to_s.length + 2
    # @board = (1..9).to_a
  end

  def get_size
    puts "What dimension would you like your board?"
    puts "Please input one integer, (N x N)"
    @n = gets.chomp.to_i
    until @n >= 3
      puts "Your board must be at least 3x3!"
      puts "Please choose a number greater than or equal to 3:"
      @n = gets.chomp.to_i
    end
    @n
  end

  def get_rows
    rows = @board.each_slice(@n).to_a
  end

  def get_columns
    board_rows = get_rows
    columns = []
    @n.times do
      board_rows.each do |x|
        columns << x.shift
      end
    end
    columns = columns.each_slice(@n).to_a
  end

  def get_diagonals
    diagonals = []
    first_column = @rows[0].first
    last_column = @rows[0].last
    diagonals << (first_column..@n**2).step(@n+1).to_a
    diagonals << (last_column..@n**2-1).step(@n-1).to_a
    diagonals
  end

  # win_combos includes the combinations for the indicies of board
  def win_combos 
    row_wins = @board.map { |x| x - 1 }.each_slice(@n).to_a
    column_wins = @columns.flatten.map { |x| x - 1 }.each_slice(@n).to_a  
    diagonal_wins = @diagonals.flatten.map { |x| x - 1 }.each_slice(@n).to_a 
    win_combos = row_wins + column_wins + diagonal_wins
  end

  # mid_rows is used in show_board to concatenate with first and last columns
  def mid_rows(row)
    rows = get_rows
    mid_rows = ""
    mid_rows = (1..@n-2).map do |x|
      "|" + rows[row][x].to_s.center(@max_length)
    end
    mid_rows = mid_rows.join
  end

  def show_board
    rows = get_rows
    rows.each_index do |row|
      first_column = rows[row][0].to_s.center(@max_length)
      last_column = "|" + rows[row][@n-1].to_s.center(@max_length)
      board_row = first_column + mid_rows(row) + last_column
      puts board_row
      puts "-"*(board_row.length-1) unless row == @n-1
    end
  end

  def replace_block(move, current_piece)
    @board[move] = current_piece
  end

  def available_blocks
    available = @board.select { |x| (1..@n**2).to_a.include?(x) }
  end
end





