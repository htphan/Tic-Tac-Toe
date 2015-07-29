require './game'

def start
  game = Game.new
  game.playing_mode
  game.start
  play_again?
end

def play_again?
  puts "Would you like to play again? (Y/N):"
  select = gets.chomp.downcase
  until select =~ /^[yn]$/
    puts "Your input was not recognized."
    puts "Please select 'Y' or 'N':"
    select = gets.chomp.downcase
  end
  if select == "y"
    start
  else
    exit
  end
end


def exit
  puts "Thank you for playing!"
end

start

