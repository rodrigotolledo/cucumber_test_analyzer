#!/usr/bin/ruby -w

require "./reports_module"
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
		@amount_of_assertions = 0
		step_definitions_files.each do |file|
			File.open(file).each_line do |line|
				if line.include?(".should")
					@amount_of_assertions +=1
					#TODO: Fix commented '.should's'
				end
			end
		end
		return @amount_of_assertions
	end
end

assertions = Assertions.new	
assertions.print_user_interaction
assertions.open_step_definitions_files(assertions.step_definitions_path)
total_of_existing_tests = assertions.verify_how_many_tests_exist(assertions.all_ruby_step_definitions_files)
total_of_assertions = assertions.verify_how_many_assertions_exist(assertions.all_ruby_step_definitions_files)

Dir.chdir(assertions.current_directory)

reports = Reports.new
reports.generate_html_report_for_assertions(assertions.quantity_of_assertions_user_input, total_of_existing_tests, total_of_assertions)
