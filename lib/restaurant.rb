class Restaurant
	@@filepath = nil
	# The attributes are used with their instance->
	# in the 'add' method(guide class).
	attr_accessor :name, :cuisine, :price

	# setter method to and access the class variable which->
	# contains the path to file that we add to and list from.
	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)
	end

	# class should know if the restaurant file exists.
	def self.file_exists?
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false
		end
	end

	# Checks if the exists,readable and writable at the same time.
	def self.file_usable?
		# Note: the first statement checks is @@filepath is nil.
		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
	end

	# creates the restaurant file unless it exists->
	# and it return the status of the file(boolean).
	def self.create_file
		File.open(@@filepath, 'w') unless file_exists?
		return file_usable?
	end

	# read the restaurant file.
	# return instances of restaurant.
	def self.saved_restaurants
	end

	# The instances are being constructed and in a hash.
	def initialize(args={})
		@name 	 = args[:name]    || ""
		@cuisine = args[:cuisine] || ""
		@price   = args[:price]   || ""	
	end

	# def save
	# 	return false unless Restaurant.file_usable?
	# 	File.open(@@filepath, 'a') do |file|
	# 		file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
	# 	end
	# 	return true
	# end

end

