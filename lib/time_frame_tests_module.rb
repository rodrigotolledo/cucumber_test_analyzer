#!/usr/bin/ruby -w

require "./slow_tests_module"
require "./reports_module"

class TimeFrameTests < SlowTests
	attr_accessor(:time_frame_scenarios, :time_frame_user_input)

	def initialize
		@time_frame_scenarios = time_frame_scenarios
		@time_frame_user_input = time_frame_user_input
	end

	def print_time_frame_message
		puts ""
		puts "[Running time_frame_module.rb...]"
		puts "What the time frame you'd like to define in order to have tests that fit on it?"
		puts "Examples:"
		puts "5;30s (tests that fit between 5 and 30 seconds)"
		puts "3;8m (tests that fit between 3 and 8 minutes)"
		print "> "
	end

	def read_and_validate_time_frame_user_input
		print_time_frame_message
		@time_frame_user_input = gets.chomp
		#TODO: improve regular expression to make sure first number is > than the second one.
		if not @time_frame_user_input.match(/^(\d{1,2});(\d{1,2})(s|m)$/)
			system("clear")
			puts "Invalid time frame. Please type values in the following format: 5;30s or 3;8m"
			read_and_validate_time_frame_user_input
		end
	end

	def print_user_interaction
		read_and_validate_time_frame_user_input
	end

	def verify_scenarios_info_time_frame(scenarios_info)
		@time_frame_user_input = split_time_frame_user_input(@time_frame_user_input)
		@time_frame_scenarios = []
		total_time = 0

		scenarios_info.each do |scenario|
			scenario[:time_in_seconds] = convert_time_format_to_seconds(scenario[:time])
		end

		time_frame_user_input_converted = convert_time_frame_user_input_to_time_format(@time_frame_user_input)
		user_input_max_seconds = convert_time_format_to_seconds(time_frame_user_input_converted)

		scenarios_info.each do |scenario|
			if(scenario[:time_in_seconds] < user_input_max_seconds && scenario[:time_in_seconds] + total_time <= user_input_max_seconds)
				@time_frame_scenarios << scenario
				total_time = total_time + scenario[:time_in_seconds]
			end
			next
		end
	end

	def convert_time_format_to_seconds(time_format)
		time_format.match(/(.*)m(.*)\.(.*)s/)
		total_seconds = ($1 * 60) + $2
		return total_seconds.to_i
	end

	def split_time_frame_user_input(time_frame_user_input)
		time_frame_user_input = time_frame_user_input.split(/;|(s|m)/)
		return time_frame_user_input
	end

	def convert_time_frame_user_input_to_time_format(time_frame_user_input)
		if(time_frame_user_input[2] == "s")
			return sprintf "%dm%.3fs", 0, time_frame_user_input[1]
		elsif(time_frame_user_input[2] == "m")
			return sprintf "%dm%.3fs", time_frame_user_input[1], 0
		end
	end

	def sort_scenarios_by_slowness(scenarios_info)
		return scenarios_info.sort_by {|scenario| scenario[:time]}.reverse
	end
end
