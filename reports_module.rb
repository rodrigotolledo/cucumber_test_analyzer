#!/usr/bin/ruby -w

require 'erb'

module ReportsModule
	class Reports
		attr_accessor(:percentage_user_input, :total_of_existing_tests, :total_of_pending_tests, :percentage_of_pending_tests)

		def initialize
			@percentage_user_input = percentage_user_input
			@total_of_existing_tests = total_of_existing_tests
			@total_of_pending_tests = total_of_pending_tests
			@percentage_of_pending_tests = percentage_of_pending_tests
		end

		def convert_erb_to_html_file(param1, param2, param3, param4)
			puts ""
			puts "[Running reports_module.rb...]"
			@percentage_user_input = param1
			@total_of_existing_tests = param2
			@total_of_pending_tests = param3
			@percentage_of_pending_tests = param4
			#TODO: generate reports in a specific reports folder
			template_file = File.open("pending_tests_template.htm.erb", 'r').read
			erb = ERB.new(template_file)
			File.open("pending_tests_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
		end
	end
end
