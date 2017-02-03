require 'yaml'

def letter? (lookAhead)
	lookAhead=~ /[[:alpha:]]/
  end

def introduction
	puts "HANGMAN\nYour objective is to try to guess the secret word the\ncomputer has generated. Good luck!"
	puts "Enter 1 for new game or 2 to load game"
end

#strip /r/n and select words that have length 5..12
def parse_dictionary(x=5,y=12)
	dictionary=[]
	File.foreach('dictionary.txt') do |line|
	  if line.chomp.length.between?(x,y)
	    dictionary << line.chomp
      end
    end
    return dictionary

end

def get_secret_word
	dictionary=parse_dictionary
	random_value=rand(0...dictionary.length)
    secret_word= dictionary[random_value].split("")
end

def load_game
	print "Enter filename: "
	filename= gets.chomp
	while(filename!="exit")
	   	if File.exist? ("#{filename}.yml")
	   		#retrieve player_data
            out=File.open("#{filename}.yml","r")
            yaml=YAML::load(out)
            return yaml
	   	else
	   		puts "File not found. Please try again or type exit."
	   		filename=gets.chomp
	   	end
	end
	return nil
end

def get_player_data
 while(true)
	choice=gets.chomp
	#NEW GAME
	if choice=="1"
        player_data=Player_data.new(get_secret_word)
        return player_data
    #LOAD GAME
	elsif choice=="2"
		player_data=load_game
		if player_data.nil?
		   puts "Enter 1 to start new game or 2 to load game:"
		else
			puts player_data#to show players history
		    return player_data
	    end
	end
 end

end
