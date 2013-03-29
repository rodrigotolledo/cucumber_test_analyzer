#!/usr/bin/ruby -w

def print_welcome_message
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
	#TODO: add exception handler
	#TODO: make menu more interactive (go and return + colors)
	@option_selected = gets.chomp
end

print_welcome_message

case @option_selected
when "1" 
	system("ruby start_pending_tests_module.rb")
when "2" 
	system("ruby start_assertions_module.rb")
when "3" 
	system("ruby start_slow_tests_module.rb")
when "4" 
	puts "Placeholder for 4."
when "5" 
	puts "Placeholder for 5."
when "?"
	puts "Placeholder for Help."
else
	puts "This option doesn't exist. Type '?' for help."
end
