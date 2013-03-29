#!/usr/bin/ruby -w

require 'erb'

class Reports

	def print_user_message
		puts ""
		puts "[Running reports_module.rb...]"
	end

	def generate_html_report_for_pending_tests(param1, param2, param3, param4)
		print_user_message
		@percentage_user_input = param1
		@total_of_existing_tests = param2
		@total_of_pending_tests = param3
		@percentage_of_pending_tests = param4
		#TODO: generate reports in a specific reports folder
		template_file = File.open("../templates/pending_tests_template.htm.erb", 'r').read
		erb = ERB.new(template_file)
		File.open("../reports/pending_tests_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
	end

	def generate_html_report_for_assertions(param1, param2, param3)
		print_user_message
		@quantity_of_assertions_user_input = param1
		@total_of_existing_tests = param2
		@total_of_assertions = param3
		#TODO: generate reports in a specific reports folder
		template_file = File.open("../templates/assertions_template.htm.erb", 'r').read
		erb = ERB.new(template_file)
		File.open("../reports/assertions_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
	end

	def generate_html_report_for_slow_tests(param1)
		print_user_message
		@scenarios_info = param1
		#TODO: generate reports in a specific reports folder
		template_file = File.open("../templates/slow_tests_template.htm.erb", 'r').read
		erb = ERB.new(template_file)
		File.open("../reports/slow_tests_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
	end
end
