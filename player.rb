
class Player
attr_accessor :name

  def initialize(name)
    @name = name.capitalize
  end

  def get_move
    puts "It's your move #{name}, give me a letter"
    gets.chomp.downcase.strip
  end

  def challenge?(fragment)
    puts "hay #{name} , the current fragment is :  #{fragment}"
    puts 'do you want to challenge the move enter \'y\' to challenge'
    return true if gets.chomp.upcase === "Y"
    false
  end

  def complete_fragment(fragment)
    puts "#{name}, You have been challenged, please complete the fragment given #{fragment}"
    completed_word = gets.chomp.downcase.strip
    if completed_word[0...fragment.length] == fragment
      return completed_word
    else
      puts "that was not a avlid input to complete the fragment"
      complete_fragment(fragment)
    end
  end

end
