require 'yaml'

class Details
	#Integer, Array, Array, Character
	attr_accessor :num_of_turns_left , :incorrect_guesses, :result,  :letter_given
    
    def initialize(turns, incorrect_guesses,result,letter)
    	@num_of_turns_left=turns
    	@incorrect_guesses=incorrect_guesses
    	@result=result
    	@letter_given=letter
    end
	
	def to_s
        puts "Turns left: #{@num_of_turns_left}  Incorrect_guesses: #{@incorrect_guesses.inspect}\n#{@result.join(" ")}\nEnter a letter:\n#{@letter_given}"
  end

end

#when player data is first created secret word is given. once and only once
class Player_data
   attr_accessor :details_array, :secret_word, :turns, :incorrect_guesses, :underlined_letters, :saved_before, :filename
    #when using new
   def initialize(secret_word)
      @secret_word=secret_word#array
      @secret=secret_word.join
   	  @details_array=[]
      @turns=6
      @incorrect_guesses=[]
      @underlined_letters=Array.new(secret_word.length,"_")
      @saved_before=false
   end
  
   def to_s
   	   "#{@details_array.each {|element| element.to_s};nil}"
   end

   def reveal_secret
      puts "You lost\nThe secret word was #{@secret}"
   end

end



