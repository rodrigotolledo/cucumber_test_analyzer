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
		puts "Placeholder for 5."
	when "?"
		puts "Placeholder for Help."
	else
		system("clear")
		puts "This option doesn't exist. Type '?' for help."
		print_welcome_message
	end
end

print_welcome_message
