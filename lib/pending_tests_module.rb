#!/usr/bin/ruby -w

require "./file_handler"

class PendingTests < FileHandler
	attr_accessor(:step_definitions_path, :all_ruby_step_definitions_files, :current_directory, :percentage_user_input)

	def percent_of(total_pending, total_tests)
		"%.1f" % (total_pending.to_f / total_tests.to_f * 100.0)
	end

	def initialize
		@step_definitions_path = step_definitions_path
		@all_ruby_step_definitions_files = all_ruby_step_definitions_files
		@current_directory = current_directory
		@percentage_user_input = percentage_user_input
	end

	def calculate_percentage_of_pending_tests(total_of_tests, total_of_pending_tests)
		percentage_of_pending_tests = percent_of(total_of_pending_tests, total_of_tests)
		return percentage_of_pending_tests
	end

	def print_user_interaction
		puts "[Running pending_tests_module.rb...]"
		puts "What percentage of pending tests is considered harmful for you? [example: 10%, 20%, 50%, etc.]"
		print "> "
		@percentage_user_input = gets.chomp
		#TODO: add exception handler
		puts "What's the directory path of your step_definitions? [example: /Users/Rodrigo/myApp/step_definitions]"
		print "> "
		@step_definitions_path = gets.chomp
		#TODO: add exception handler
		puts ""
	end

	def verify_how_many_pending_tests_exist(step_definitions_files)
		@amount_of_pending_tests = verify_how_many("pending")
		return @amount_of_pending_tests
	end
end


