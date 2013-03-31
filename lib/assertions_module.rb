#!/usr/bin/ruby -w

require "./file_handler"

class Assertions < FileHandler
	attr_accessor(:step_definitions_path, :all_ruby_step_definitions_files, :current_directory, :quantity_of_assertions_user_input)

	def initialize
		@step_definitions_path = step_definitions_path
		@all_ruby_step_definitions_files = all_ruby_step_definitions_files
		@current_directory = current_directory
		@quantity_of_assertions_user_input = quantity_of_assertions_user_input
	end

	def print_user_interaction
		puts "[Running assertions_module.rb...]"
		puts "What is considered to you as a maximum good quantity of assertions by test scenario? [default: 3]"
		print "> "
		@quantity_of_assertions_user_input = gets.chomp
		#TODO: fix regular expression to don't allow '00'
		if not @quantity_of_assertions_user_input.match(/^((?!0$)[0-9]{1,2})$/)
			system("clear")
			puts "Invalid entry. Please, type a quantity of assertions between 1 and 99."
			print_user_interaction
		else
			#TODO: refactory this code, it's the same thing of pending_tests_module.
			puts "What's the directory path of your step_definitions? [example: /Users/Rodrigo/myApp/step_definitions]"
			print "> "
			@step_definitions_path = gets.chomp
			if File.directory?(@step_definitions_path)
				files = Dir.glob("**/*.rb")
				while files.empty?
					puts "Sorry, there isn't any step definitions (*.rb) files inside this path. Please type a valid path that contains your step definitions."
					print "> "
					@step_definitions_path = gets.chomp
				end
			else
				while not File.directory?(@step_definitions_path)
					puts "This path doesn't exist. Please type a valid path that contains your step_definitions."
					print "> "
					@step_definitions_path = gets.chomp
				end
			end
			puts ""
		end
	end

	def verify_how_many_assertions_exist
		@amount_of_assertions = verify_how_many(".should")
		return @amount_of_assertions
	end
end
