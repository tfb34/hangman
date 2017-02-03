require 'yaml'
require_relative './tools'
require_relative './player_data'
require_relative './save_tools'

introduction
player_data=get_player_data

#BEGIN GAME
while(player_data.turns>0)

puts "Turns left: #{player_data.turns}   Incorrect_guesses: #{player_data.incorrect_guesses.inspect}\n#{player_data.underlined_letters.join(" ")}"
#if player has guessed all letters correctly, there should be only one unique character which is ""
if player_data.secret_word.uniq.length==1  
 break
end

puts "Enter a letter: "
#Player may enter a letter or save game or exit
 while(true)
	letter_given=gets.chomp
	if letter_given=="save" #SAVE GAME
	  redirect_save(player_data)
	  exit #GAME ends 
    elsif letter_given=="quit" #quit
      exit
	elsif letter_given.length==1 && !(letter?(letter_given)).nil?#checks if input is a letter. otherwise will crash in casecmp
	  break
     end
 end
#creates new Details object to add onto existing player_data
#player_data is the object that gets serialized later on
player_data.details_array << Details.new(player_data.turns,player_data.incorrect_guesses.dup,player_data.underlined_letters.dup,letter_given)

#GIVEN a letter, collect the positions of where a match was made
matches = player_data.secret_word.each_index.select {|i| player_data.secret_word[i].casecmp(letter_given)==0}

#no matches found. Update turns and "incorrect_guess bank"
 if matches.empty?
	player_data.turns-=1
	player_data.incorrect_guesses << letter_given
 else
# Match found.Update secret_word and underlined_letters
	matches.each do |index| 
	  player_data.underlined_letters[index]=player_data.secret_word[index]
	  player_data.secret_word[index]=""
	end
 end

end
#GAME ENDS
if player_data.turns>0
	puts "Congratulations, you won!"
else
	player_data.reveal_secret
end

optional_save(player_data)

exit
