#!/usr/bin/ruby -w

def print_welcome_message
	puts "
Welcome to the Cucumber Tests Analyzer!
  Type the number of the option you'd like to use:
  [1] Pending Tests Module
  [2] Assertions Module
  [3] Slow Tests Module
  [4] Extensive Tests Module
  [5] Time Frame Tests Module
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
	puts "Voce selecionou opcao 3"
when "4" 
	puts "Voce selecionou opcao 4"
when "5" 
	puts "Voce selecionou opcao 5"
when "?"
	puts "Help Description... bla bla bla."
else
	puts "Essa opcao nao existe!"
end
