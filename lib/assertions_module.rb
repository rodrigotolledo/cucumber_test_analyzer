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
		#TODO: add exception handler
		puts "What's the directory path of your step_definitions? [example: /Users/Rodrigo/myApp/step_definitions]"
		print "> "
		@step_definitions_path = gets.chomp
		#TODO: add exception handler
		puts ""
	end

	def verify_how_many_assertions_exist(step_definitions_files)
		@amount_of_assertions = verify_how_many(".should")
		return @amount_of_assertions
	end
end
