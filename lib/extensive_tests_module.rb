#!/usr/bin/ruby -w

# Flow:
# 1) User provide maximum size of Scenario (example: 5 lines, 8 lines, 10 lines, etc.)
# 2) Read each Scenario and count how many lines it has.
# 3) Send results to Reports module (if Scenario[:number_of_lines] > user_input then BAD, else OK)

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
		puts "What's the maximum number of lines considered OK for your Scenarios? (must be between 3 and 30. Example: 3, 8, 20, etc.)"
		print "> "
		@maximum_number_of_lines_user_input = gets.chomp
		if not @maximum_number_of_lines_user_input.match(/\b0*([3-9]|[12][0-9]|30)\b/)
			system("clear")
			puts "Invalid entry! Please type a maximum number of lines between 3 and 30."
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

	#TODO: remove this later!
	def get_quantity_of_steps(file)
		lines = File.readlines(file)
		scenarios = [:name => "", :steps => []]
		lines.each do |line|
			line.chomp!
			next if line.empty?
			if line.include? "Scenario:"
				scenarios << {:name => line, :steps => []} 
				next
			end 
			scenarios.last[:steps] << line
		end
		scenarios.each do |scenario|
			if not scenario[:name].empty?
				puts "#{scenario[:name]} has #{scenario[:steps].size} steps"
			end
		end
	end
	
	#TODO: There is a known issue here when adding non-scenario block to array.
	def get_scenarios_info
		@scenarios_info = [:scenario_name => "", :quantity_of_steps => []]
		@all_files.each do |file|
			line_counter = 0
			File.open(file).each_line do |line|
				line.chomp!
				next if line.empty?
				line_counter = line_counter + 1
				if line.include? "Scenario:"
					@scenarios_info << {:scenario_name => line, :scenario_line => line_counter, :feature_file => file, :quantity_of_steps => []}
					next
				end
				@scenarios_info.last[:quantity_of_steps] << line
			end
		end

		#TODO: fix me here!
		@scenarios_info.each do |scenario|
			#		if scenario[:scenario_name] == ""
			#			@scenarios_info.delete(scenario)
			#		end
			scenario[:quantity_of_steps] = scenario[:quantity_of_steps].size
		end
		#TODO: sort by most quantity_of_steps
		puts @scenarios_info
	end
end
