#!/usr/bin/ruby -w

require "./file_handler"

class PendingTests < FileHandler
	attr_accessor(:step_definitions_path, :all_ruby_step_definitions_files, :current_directory, :percentage_user_input)

	def initialize
		@step_definitions_path = step_definitions_path
		@all_ruby_step_definitions_files = all_ruby_step_definitions_files
		@current_directory = current_directory
		@percentage_user_input = percentage_user_input
	end

	def percent_of(total_pending, total_tests)
		"%.1f" % (total_pending.to_f / total_tests.to_f * 100.0)
	end

	def calculate_percentage_of_pending_tests(total_of_tests, total_of_pending_tests)
		percentage_of_pending_tests = percent_of(total_of_pending_tests, total_of_tests) + "%"
		return percentage_of_pending_tests
	end

	def print_percentage_of_pending_tests_message
		puts ""
		puts "[Running pending_tests_module.rb...]"
		puts "What percentage of pending tests is considered harmful for you? [example: 10%, 20%, 50%, etc.]"
		print "> "
	end

	def read_and_validate_percentage_user_input
		print_percentage_of_pending_tests_message
		@percentage_user_input = gets.chomp
		if not @percentage_user_input.match(/^(100|[1-9][0-9]?)%$/)
			system("clear")
			puts "Invalid percentage. Examples of correct use: 5%, 23%, 50%, etc."
			read_and_validate_percentage_user_input
		end
	end

	def print_user_interaction
		read_and_validate_percentage_user_input
		read_and_validate_step_definitions_path
	end

	def verify_how_many_pending_tests_exist
		@amount_of_pending_tests = verify_how_many("pending")
		return @amount_of_pending_tests
	end
end
