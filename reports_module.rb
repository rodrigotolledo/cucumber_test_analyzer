#!/usr/bin/ruby -w

require 'erb'

puts ""
puts "[Running reports_module.rb...]"

ARGV.each do
	@percentage_user_input = ARGV[0]
	@total_of_existing_tests = ARGV[1]
	@total_of_pending_tests = ARGV[2]
	@percentage_of_pending_tests = ARGV[3]
end

def convert_erb_to_html_file
	#TODO: generate reports in a specific reports folder
	template_file = File.open("pending_tests_template.htm.erb", 'r').read
	erb = ERB.new(template_file)
	File.open("pending_tests_report.htm", 'w+') { |file| file.write(erb.result(binding)) }
end

convert_erb_to_html_file
