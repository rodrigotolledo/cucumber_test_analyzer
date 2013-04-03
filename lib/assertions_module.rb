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

	def print_quantity_of_assertions_message
		puts "[Running assertions_module.rb...]"
		puts "What is considered to you as a maximum good quantity of assertions by test scenario? [default: 3]"
		print "> "
	end

	def read_and_validate_quantity_of_assertions_user_input
		print_quantity_of_assertions_message
		@quantity_of_assertions_user_input = gets.chomp
		if not @quantity_of_assertions_user_input.match(/^[1-9][0-9]?$/)
			system("clear")
			puts "Invalid entry. Please, type a quantity of assertions between 1 and 99."
			read_and_validate_quantity_of_assertions_user_input
		end
	end

	def print_user_interaction
		read_and_validate_quantity_of_assertions_user_input	
		read_and_validate_step_definitions_path			
	end

	def verify_how_many_assertions_exist
		@amount_of_assertions = verify_how_many(".should")
		return @amount_of_assertions
	end
end
