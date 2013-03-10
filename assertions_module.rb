#!/usr/bin/ruby -w

# Flow
# 1) Open step_definitions file
# 2) Count how many tests (Given's) exist
# 3) Count how many assertions (.should's) exist
# 4) Analyze if quantity of assertions are less than one or more than three
# 5) Send results to reports_module.rb

require "./reports_module"

module AssertionsModule
	include ReportsModule

	class Assertions
		attr_accessor(:step_definitions_path, :all_ruby_step_definitions_files, :current_directory, :quantity_of_assertions_user_input)

		def initialize
			@step_definitions_path = step_definitions_path
			@all_ruby_step_definitions_files = all_ruby_step_definitions_files
			@current_directory = current_directory
			@quantity_of_assertions_user_input = quantity_of_assertions_user_input
		end

		def print_user_interaction
			puts "[Running assetions_module.rb...]"
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

		def open_step_definitions_files(step_definitions_path)
			@current_directory = Dir.pwd
			Dir.chdir(step_definitions_path)
			#TODO: add exception handler
			@all_ruby_step_definitions_files = Dir.glob("**/*.rb")
			puts "Step Definitions files to be analyzed: #{@all_ruby_step_definitions_files}."
		end

		def verify_how_many_tests_exist(step_definitions_files)
			@amount_of_existing_tests = 0
			step_definitions_files.each do |file|
				File.open(file).each_line do |line|
					if line.include?("Given")
						@amount_of_existing_tests +=1
						#TODO: Fix commented 'Given's'
					end
				end
			end
			return @amount_of_existing_tests
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
	#TODO: send results do ReportsModule.
	puts "Quantity of assertions defined by the user: #{assertions.quantity_of_assertions_user_input}"
	puts "Total of existing tests found: #{total_of_existing_tests}"
	puts "Total of assertions found: #{total_of_assertions}"
end
