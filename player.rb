
class Player
attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts "It's your move #{name}, give me a letter"
    gets.chomp.downcase.strip
  end

  def challenge?(fragment)
    puts "hay #{name} , the current fagment is :  #{fragment}"
    puts 'do you want to challenge the move enter y/n'
    return true if gets.chomp.upcase === "Y"
    false
  end

  def complete_fragment(fragment)
    puts "You have been challenged, please complete the fragment given #{fragment}"
    gets.chomp.downcase.strip
  end

end
