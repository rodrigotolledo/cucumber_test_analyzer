#!/usr/bin/ruby -w

require "./reports_module"
require "./file_handler"

class PendingTests < FileHandler
	attr_accessor(:step_definitions_path, :all_ruby_step_definitions_files, :current_directory, :percentage_user_input)

	class Numeric
		def percent_of(total_pending, total_tests)
			"%.1f" % (total_pending.to_f / total_tests.to_f * 100.0)
		end
	end

	def initialize
		@step_definitions_path = step_definitions_path
		@all_ruby_step_definitions_files = all_ruby_step_definitions_files
		@current_directory = current_directory
		@percentage_user_input = percentage_user_input
	end

	def calculate_percentage_of_pending_tests(total_of_tests, total_of_pending_tests)
		percentage_of_pending_tests = Numeric.new.percent_of(total_of_pending_tests, total_of_tests)
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
		@amount_of_pending_tests = 0
		@all_ruby_step_definitions_files.each do |file|
			File.open(file).each_line do |line|
				if line.include?("pending")
					@amount_of_pending_tests +=1
					#TODO: Fix commented 'pending's'
				end
			end
		end
		return @amount_of_pending_tests
	end
end

pendingTests = PendingTests.new
pendingTests.print_user_interaction
pendingTests.open_step_definitions_files(pendingTests.step_definitions_path)
total_of_existing_tests = pendingTests.verify_how_many_tests_exist(pendingTests.all_ruby_step_definitions_files)
total_of_pending_tests = pendingTests.verify_how_many_pending_tests_exist(pendingTests.all_ruby_step_definitions_files)
percentage_of_pending_tests = pendingTests.calculate_percentage_of_pending_tests(total_of_existing_tests, total_of_pending_tests)

Dir.chdir(pendingTests.current_directory)

reports = Reports.new
reports.generate_html_report_for_pending_tests(pendingTests.percentage_user_input, total_of_existing_tests, total_of_pending_tests, percentage_of_pending_tests)
