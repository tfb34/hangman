require 'yaml'

def save(player_data)
  filename=player_data.filename
  serialized_object=YAML::dump(player_data)
  File.open("#{filename}.yml","w") do |f|
  	f.puts serialized_object
  end
  puts "#{filename}.yml successfully saved."
end
#First time save
def save_as(player_data)
   	filename=get_new_filename
   	player_data.saved_before=true
   	player_data.filename=filename

   	serialized_object=YAML::dump(player_data)
	
	outfile=File.new("#{filename}.yml", "w+")
    outfile.puts(serialized_object)
    outfile.close

    puts "#{filename}.yml successfully saved."
end

#obtains a non-existing filename
def get_new_filename
	print "save as?\nEnter filename: "
    filename= gets.chomp
    while(filename==""|| File.exist?("#{filename}.yml"))
    	puts "Invalid/That file already exists. Save as? "
    	filename=gets.chomp
    end
    return filename
end

def optional_save(player_data)
 exit_flag=100
 while(exit_flag>0)
  puts "Would you like to save game? y/n"
  input=gets.chomp
  
  if input.downcase=="y"
	redirect_save(player_data)
    break
  elsif input.downcase=="n"
	break
  end
  
  exit_flag-=1
 end	

end

def redirect_save(player_data)
 if player_data.saved_before
 	save(player_data)
 else
 	save_as(player_data)
 end
end