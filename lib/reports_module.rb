#!/usr/bin/ruby -w

require 'erb'

class Reports

	def print_user_message
		puts ""
		puts "[Running reports_module.rb...]"
	end

	def generate_html_report_for_pending_tests(percentage_user_input, total_of_existing_tests, total_of_pending_tests, percentage_of_pending_tests)
		print_user_message
		@percentage_user_input = percentage_user_input
		@total_of_existing_tests = total_of_existing_tests
		@total_of_pending_tests = total_of_pending_tests
		@percentage_of_pending_tests = percentage_of_pending_tests
		template_file = File.open("../templates/pending_tests_template.htm.erb", 'r').read
		erb = ERB.new(template_file)
		File.open("../reports/pending_tests_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
	end

	def generate_html_report_for_assertions(quantity_of_assertions_user_input, total_of_existing_tests, total_of_assertions)
		print_user_message
		@quantity_of_assertions_user_input = quantity_of_assertions_user_input
		@total_of_existing_tests = total_of_existing_tests
		@total_of_assertions = total_of_assertions
		template_file = File.open("../templates/assertions_template.htm.erb", 'r').read
		erb = ERB.new(template_file)
		File.open("../reports/assertions_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
	end

	def generate_html_report_for_slow_tests(scenarios_info)
		print_user_message
		@scenarios_info = scenarios_info
		template_file = File.open("../templates/slow_tests_template.htm.erb", 'r').read
		erb = ERB.new(template_file)
		File.open("../reports/slow_tests_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
	end
end
