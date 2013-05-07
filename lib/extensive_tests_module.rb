#!/usr/bin/ruby -w

require "./file_handler"

class ExtensiveTests < FileHandler
	attr_accessor(:maximum_number_of_lines_user_input, :feature_files_path, :current_directory, :scenarios_info)

	def initialize
		@maximum_number_of_lines_user_input = maximum_number_of_lines_user_input
		@feature_files_path = feature_files_path
		@current_directory = current_directory
		@scenarios_info = scenarios_info
	end

	def print_maximum_number_of_lines_message
		puts "What's the maximum number of Steps considered OK for your Scenarios? (must be between 3 and 30. Example: 3, 8, 20, etc.)"
		print "> "
		@maximum_number_of_lines_user_input = gets.chomp
		if not @maximum_number_of_lines_user_input.match(/\b0*([3-9]|[12][0-9]|30)\b/)
			system("clear")
			puts "Invalid entry! Please type a maximum number of Steps between 3 and 30."
			print_maximum_number_of_lines_message
		end
	end

	#TODO: refactory this frankenstein (it's similar to the slow_tests_module.rb)
	def print_feature_files_message
		puts "What's the directory path of your .feature files? [example: /Users/Rodrigo/myApp/features]"
		print "> "         
		@feature_files_path = gets.chomp
		if File.directory?(@feature_files_path)
			@current_directory = Dir.pwd
			Dir.chdir(@feature_files_path)
			files = Dir.glob("**/*.feature")
			while files.empty?
				puts "Sorry, there isn't any feature files (*.feature) inside this path. Please type a valid path that contains your feature files."
				print "> "
				@feature_files_path = gets.chomp
			end
			Dir.chdir(@current_directory)
		else
			while not File.directory?(@feature_files_path)
				puts "This path doesn't exist. Please type a valid path that contains your feature files."
				print "> "
				@feature_files_path = gets.chomp
			end 
		end
		puts ""
	end

	def print_user_interaction
		print_maximum_number_of_lines_message
		print_feature_files_message
	end

	def count_steps_for_scenario(scenario_line_number, lines)
		count = 0
		(scenario_line_number..(lines.size-1)).each do |line_number|
			break if lines[line_number].chomp.empty?
			count+=1
		end
		count
	end

	def get_scenarios_info
		@scenarios_info = []
		@all_files.each do |file|
			ignore_words = ["@javascript","@wip","@aspects","Feature","In order","As a","I want"]   
			#ignore_words = ["#","Feature","In order","As a","I want"]   
			line_counter = 0
			all_lines = File.readlines(file)
			File.open(file).each_line do |line|
				line_counter = line_counter + 1
				line.chomp!
				next if line.empty? || ignore_words.any? { |word| line =~ /#{word}/ }
				if line.include? "Scenario:"
					@scenarios_info << {:scenario_name => line, :scenario_line => line_counter, :feature_file => file, :quantity_of_steps => []}
					next
				end
				quantity_of_steps = count_steps_for_scenario(line_counter, all_lines)	
				@scenarios_info.last[:quantity_of_steps] << quantity_of_steps
			end
		end
		@scenarios_info.each do |scenario|
			scenario[:quantity_of_steps] = scenario[:quantity_of_steps].size
			if scenario[:scenario_name].empty?
				@scenarios_info.delete(scenario)
			end
		end
		@scenarios_info = parse_scenarios_info(@scenarios_info)
		@scenarios_info = sort_scenarios_by_quantity_of_steps(@scenarios_info)
	end
	
	def parse_scenarios_info(scenarios_info)
		scenarios_info.each do |item|
			item[:scenario_name].gsub!(/[\t|\n]/, "")
		end
		return scenarios_info
	end

	def sort_scenarios_by_quantity_of_steps(scenarios_info)
		return scenarios_info.sort_by {|scenario| scenario[:quantity_of_steps]}.reverse
	end
end
