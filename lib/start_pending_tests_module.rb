#!/usr/bin/ruby -w

require "./pending_tests_module"
require "./reports_module"
require "./file_handler"

pendingTests = PendingTests.new
pendingTests.print_user_interaction
pendingTests.open_step_definitions_files(pendingTests.step_definitions_path)
total_of_existing_tests = pendingTests.verify_how_many("Given")
total_of_pending_tests = pendingTests.verify_how_many_pending_tests_exist
percentage_of_pending_tests = pendingTests.calculate_percentage_of_pending_tests(total_of_existing_tests, total_of_pending_tests)
Dir.chdir(pendingTests.current_directory)
reports = Reports.new
reports.generate_html_report_for_pending_tests(pendingTests.percentage_user_input, total_of_existing_tests, total_of_pending_tests, percentage_of_pending_tests)
