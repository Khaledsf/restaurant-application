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
		if Restaurant.file_exists? == true
			file = File.read("restaurant.txt")
			puts file
		else 
			puts "There are no entries. Please start a list."
		end
	end

	# Writes to file the entries.
	def add
		puts "\nAdd a restaurant\n\n".upcase
		restaurant = Restaurant.new

		print "Restaurant name: "
		restaurant.name = gets.chomp.strip

		print "Cuisine type: "
		restaurant.cuisine = gets.chomp.strip

		print "Average price: "
		restaurant.price = gets.chomp.strip

		if restaurant.save
			puts "\nRestaurant Added\n\n"
		else
			puts "\nSave Error: restaurant not added\n\n"	
		end
	
	end

	def find
		puts "Enter keyword."
		puts "Exemple: Mexican, Mex..."
		userKeyword = gets.chomp.downcase.strip
		arr = Array.new
		File.readlines('restaurant.txt').each do |line|
			value = line.split("\t")[1].downcase.strip
			if value.include?(userKeyword)
				arr.push(line)
			end
		end
		puts arr
	end

	# A method that lists restaurant under the enterd price.
	def sort
		puts "Enter maximum price."
		userChoice = gets.chomp.to_i
		arr = Array.new
		File.readlines('restaurant.txt').each do |line|
			price = line.split("\t").last.delete("\n").to_i
			if price < userChoice
				arr.push(line)
			end
		end
		if arr.empty?
			puts "Can not find anything within that price range. Try higher price. "
		else
			puts arr
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

end