require 'restaurant'
class Guide
	# In order to make our class reusable
	# we pass in parametre of path set to nil
	def initialize(path)
		Restaurant.filepath = path
		if Restaurant.file_usable?
			puts "Found restaurant file."
		elsif Restaurant.create_file
			puts "Created restaurant file."
		else 
			puts "Exiting..."
			exit!
		end
	end

	# Reads from file to list entries.
	def list
		output_action_header("***Listing restaurants***")
		restaurants = Restaurant.saved_restaurants
		output_restaurant_table(restaurants)
	end

	# Writes to file the entries.
	def add
		puts "\n\n\nAdd a restaurant\n\n".upcase
		restaurant = Restaurant.build_using_questions
		if restaurant.save
			puts "\nRestaurant Added\n\n"
		else
			puts "\nSave Error: restaurant not added\n\n"	
		end
	end

	#Searches in the storage file for items based on keywords.
	def find
		puts "Enter keyword, EX: Mexican or Mex"
		userKeyword = gets.chomp.downcase.strip
		restaurants = Restaurant.saved_restaurants
		found_restaurant_array = []
			restaurants.each do |rest|
			if rest.cuisine.include?(userKeyword)
				found_restaurant_array << rest
			end
		end
		if !found_restaurant_array.empty?
		output_restaurant_table(found_restaurant_array)
		else
			output_action_footer("oops! could not find an entry")
		end
	end

	# A method that lists restaurant under the enterd price.
	def sort
		puts "Enter maximum price."
		user_choice = gets.chomp.to_i
		output_action_header("***sortingting restaurants***")
		restaurants = Restaurant.saved_restaurants
		found_restaurant_array = []
			restaurants.each do |rest|
			if rest.price.to_i <= user_choice
				found_restaurant_array << rest
			end
		end
		if !found_restaurant_array.empty?
		output_restaurant_table(found_restaurant_array)
		else
			output_action_footer("oops! could not find an entry")
		end
	end

	# The 'luaunch!' method starts the app, it calls ->
	# the method 'do_action' that takes user's input as argument->
	# that calls other methods.
	def launch!
		introduction

		result = nil
		until result == :quit
			print "> Choose one of these options: List, Sort, Find or Add.\n\n"
			user_response = gets.chomp
			result = do_action(user_response)
		end
		conclusion
	end

	#Grabs the user's input then calls the method(s).
	def do_action(action)
		case action
		when 'list'
			list()
		when 'find'
			puts 'Finding...'
			find()
		when 'sort'
			sort()
		when 'add'
			add()
		when 'quit'
			return :quit
		else
			puts "\nI don't understand that command.\n"
		end
	end

	def introduction; puts "\n*****Welcome to restaurant finder*****\n\n";end
	def conclusion; puts "\n\n*****Thank you for using this App*****\n\n";end

	

	private

	def output_action_header(text)
		puts "\n#{text.upcase.center(60)}\n\n"
	end

	def output_action_footer(text)
		puts "\n\n#{text.upcase.center(60)}\n"
	end

	def output_restaurant_table(restaurants=[])
		print " " + "Name".ljust(30)
		print " " + "Cuisine".ljust(20)
		print " " + "Price".ljust(6) + "\n"
		puts "-" * 60
		restaurants.each do |rest|
			line = " " << rest.name.ljust(30)
			line << " " + rest.cuisine.ljust(20)
			line << " " + rest.formatted_price.rjust(6)
			puts line
		end
		puts "No listing found" if restaurants.empty?
		puts "-" * 60
	end

end