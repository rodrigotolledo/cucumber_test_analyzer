#!/usr/bin/ruby -w

require "./reports_module"

# Flow:
# Read .feature files
# Take note of each Scenario name and which Line it starts.
# Run each Scenario individually (specifying line number).
# Get the time execution of each Scenario.
# Send .feature file name, Scenario name and time execution to Reports Module.

@all_feature_files = ["/Users/Thoughtworks/Documents/my_stuff/TCC2-here-we-go/test_app/step_definitions/calculator/addition.feature", 
	"/Users/Thoughtworks/Documents/my_stuff/TCC2-here-we-go/test_app/step_definitions/calculator/addition2.feature"]

def get_scenarios_info
	@scenarios_info = []
	@all_feature_files.each do |file|
		line_counter = 0
		File.open(file).each_line do |line|
			line_counter = line_counter + 1
			if line.include?("Scenario:")
				@scenarios_info << {:scenario_name => line, :scenario_line => line_counter, :feature_file => file, :time => ""}
			end
		end
	end
	#puts @scenarios_info
end

def run_scenarios
	@scenarios_info.each do |scenario_info|	
		system("cucumber #{scenario_info[:feature_file]}:#{scenario_info[:scenario_line]} > results_temp.log")
		results = File.open("results_temp.log")
		scenario_info[:time] = results.readlines.last
	end
	puts parse_scenarios_info(@scenarios_info)
end

def parse_scenarios_info(scenarios_info)
	scenarios_info.each do |item|
		item[:scenario_name].gsub!(/[\t|\n]/, "")
		item[:time].gsub!("\n", "")
	end
	return scenarios_info
end

get_scenarios_info
run_scenarios
reports = Reports.new
reports.generate_html_report_for_slow_tests(@scenarios_info)
