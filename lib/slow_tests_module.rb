#!/usr/bin/ruby -w

require "./file_handler"

class SlowTests < FileHandler
	attr_accessor(:feature_files_path, :scenarios_info, :current_directory)

	def inititalize
		@feature_files_path = feature_files_path
		@scenarios_info = scenarios_info
		@current_directory = current_directory
	end

	#TODO: Refactory this frankenstein...
	def print_user_interaction
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

	def get_scenarios_info
		@scenarios_info = []
		@all_files.each do |file|
			line_counter = 0
			File.open(file).each_line do |line|
				line_counter = line_counter + 1
				if line.include?("Scenario:")
					@scenarios_info << {:scenario_name => line, :scenario_line => line_counter, :feature_file => file, :time => ""}
				end
			end
		end
	end

	def run_scenarios
		@scenarios_info.each do |scenario_info|	
			system("cucumber #{scenario_info[:feature_file]}:#{scenario_info[:scenario_line]} > results_temp.log")
			results = File.open("results_temp.log")
			scenario_info[:time] = results.readlines.last
		end
		@scenarios_info = parse_scenarios_info(@scenarios_info)
		@scenarios_info = sort_scenarios_by_slowness(@scenarios_info)
	end

	def parse_scenarios_info(scenarios_info)
		scenarios_info.each do |item|
			item[:scenario_name].gsub!(/[\t|\n]/, "")
			item[:time].gsub!("\n", "")
		end
		return scenarios_info
	end

	def sort_scenarios_by_slowness(scenarios_info)
		return scenarios_info.sort_by {|scenario| scenario[:time]}.reverse
	end

end
