#!/usr/bin/ruby -w

class Numeric
	def percent_of(n)
		"%.1f" % (self.to_f / n.to_f * 100.0)
	end
end

def calculate_percentage_of_pending_tests(total_of_tests, total_of_pending_tests)
	percentage_of_pending_tests = total_of_pending_tests.percent_of(total_of_tests)
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

def verify_how_many_pending_tests_exist(step_definitions_files)
	@amount_of_pending_tests = 0
	step_definitions_files.each do |file|
		File.open(file).each_line do |line|
			if line.include?("pending")
				@amount_of_pending_tests +=1
				#TODO: Fix commented 'pending's'
			end
		end
	end
	return @amount_of_pending_tests
end

print_user_interaction
open_step_definitions_files(@step_definitions_path)
total_of_existing_tests = verify_how_many_tests_exist(@all_ruby_step_definitions_files)
total_of_pending_tests = verify_how_many_pending_tests_exist(@all_ruby_step_definitions_files)
percentage_of_pending_tests = calculate_percentage_of_pending_tests(total_of_existing_tests, total_of_pending_tests)
Dir.chdir(@current_directory)
system("ruby reports_module.rb #{@percentage_user_input} #{total_of_existing_tests} #{total_of_pending_tests} #{percentage_of_pending_tests}")
