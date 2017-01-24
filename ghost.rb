require_relative 'player.rb'
require 'set'
# require  'byebug'

class Ghost
  attr_accessor :dictionary , :fragment, :players, :current_player, :scores , :previous_player

  def initialize(dictionary_file, players)
    populate_dictionary(dictionary_file)
    @players = players
    @current_player = players[0]
    @scores = Hash.new(0)
    @fragment = ""
  end

  def populate_dictionary(dictionary_file)
    file = File.new(dictionary_file)
    @dictionary = Set.new()
    file.each_line do |line|
      @dictionary << line.chomp
    end
  end


  def run_game
    while players.count > 1
      take_turn
      challenger = any_challenge
      challenge_mode(challenger) if challenger
      drop_players! if any_player_to_drop?
      if game_over?
        end_game
        exit
      end
      next_player!
    end

  end

  def any_challenge
    other_players = players.select{|player| player != current_player}
    other_players.each do |other_player|
        return other_player if other_player.challenge?(fragment)
    end

    nil
  end

  def challenge_mode(challenging_player)
    completed_word =current_player.complete_fragment(fragment)
    if dictionary.include?(completed_word)
      @scores[challenging_player] +=1
        puts "#{current_player.name} won the challenge"
        puts "#{challenging_player.name} has #{format_score(scores[challenging_player])}"
    else
      @scores[current_player] += 1
        puts "#{challenging_player.name} won the challenge"
        puts "#{current_player.name} has #{format_score(scores[current_player])}"
    end

    @fragment = ""
  end

  def format_score(score)
    "ghost".upcase[0...score]

  end

  def next_player!
    @previous_player = current_player
    next_player_idx = players.index(current_player) + 1
    if next_player_idx == players.length
      @current_player = players[0]
    else
      @current_player = players[next_player_idx]
    end
  end

  def take_turn
    current_player_move = current_player.get_move
    if valid_play?(current_player_move)
      update_frag(current_player_move)
    else
      take_turn
    end
  end

  def valid_play?(str)
    return true if (('a'..'z').include?(str))
    false
  end

  def update_frag(current_player_move)
    @fragment << current_player_move
  end

# dont drop the current player
  def drop_players!
    @current_player = previous_player if scores[current_player]== 5
    @players.delete_if{|player| player == scores.key(5)}
  end

  def any_player_to_drop?
    return true if !scores.values.empty? && scores.values.include?(5)
    false
  end

  def end_game
    puts "winner is #{players[0].name}"
  end

  def game_over?
    return true if players.length == 1
    false
  end

end

if (__FILE__ == $PROGRAM_NAME)
  puts "please give me the number of players"
   number_of_players = Integer(gets.chomp)

  players = []
  for x in 0...number_of_players
    puts "Player\##{x} name?"
    player_name = gets.chomp
    players << Player.new(player_name)
  end

  game = Ghost.new('dictionary.txt', players)
  game.run_game
end
