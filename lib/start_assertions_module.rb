#!/usr/bin/ruby -w

require "./assertions_module"
require "./reports_module"
require "./file_handler"

assertions = Assertions.new	
assertions.print_user_interaction
assertions.open_step_definitions_files(assertions.step_definitions_path)
#total_of_existing_tests = assertions.verify_how_many_tests_exist(assertions.all_ruby_step_definitions_files)
total_of_existing_tests = assertions.verify_how_many_tests_exist
total_of_assertions = assertions.verify_how_many_assertions_exist(assertions.all_ruby_step_definitions_files)

Dir.chdir(assertions.current_directory)

reports = Reports.new
reports.generate_html_report_for_assertions(assertions.quantity_of_assertions_user_input, total_of_existing_tests, total_of_assertions)
