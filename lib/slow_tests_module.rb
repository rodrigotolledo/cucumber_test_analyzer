#!/usr/bin/ruby -w

#TODO: sort and print Scenarios time execution by slowness.

require "./reports_module"
require "./file_handler"

class SlowTests < FileHandler
	attr_accessor(:feature_files_path, :all_feature_files, :scenarios_info, :current_directory)

	def inititalize
		@feature_files_path = feature_files_path
		@all_feature_files = all_feature_files
		@scenarios_info = scenarios_info
		@current_directory = current_directory
	end

	def print_user_interaction
		puts "What's the directory path of your .feature files? [example: /Users/Rodrigo/myApp/features]"
		print "> "         
		@feature_files_path = gets.chomp
		puts ""		
	end

	def get_scenarios_info(all_feature_files)
		@scenarios_info = []
		all_feature_files.each do |file|
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
		#puts parse_scenarios_info(@scenarios_info)
	end

	def parse_scenarios_info(scenarios_info)
		scenarios_info.each do |item|
			item[:scenario_name].gsub!(/[\t|\n]/, "")
			item[:time].gsub!("\n", "")
		end
		return scenarios_info
	end
end
