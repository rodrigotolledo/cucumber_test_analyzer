#!/usr/bin/ruby -w

def print_welcome_message
	system("clear")
	puts "
Welcome to the Cucumber Tests Analyzer!
  Type the number of the Module you'd like to use:
  [1] Pending Tests
  [2] Assertions
  [3] Slow Tests
  [4] Extensive Tests
  [5] Time Frame Tests
  [?] Help
	"
	print "> "
	@option_selected = gets.chomp
	case @option_selected
	when "1" 
		system("ruby start_pending_tests_module.rb")
	when "2" 
		system("ruby start_assertions_module.rb")
	when "3" 
		system("ruby start_slow_tests_module.rb")
	when "4" 
		system("ruby start_extensive_tests_module.rb")
	when "5" 
		system("ruby start_time_frame_tests_module.rb")
	when "?"
		puts "Cucumber Test Analyzer - Help"
		puts "Pending Tests Module - it will help you analyze percentage of pending tests."
		puts "Assertions Module - it will help you analyze overall quantity of tests and assertions."
		puts "Slow Tests Module - it will run each test and organize them by slowness."
		puts "Extensive Tests Module - it will help to identify tests that have more steps than defined by user."
		puts "Time Frame Tests Module - it will run each test and identify which of them are between a time frame defined by user."
	else
		system("clear")
		puts "This option doesn't exist. Type '?' for help."
		print_welcome_message
	end
end

print_welcome_message
