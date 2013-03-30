#!/usr/bin/ruby -w

require "./reports_module"
require "./slow_tests_module"
require "./file_handler"

slowTests = SlowTests.new
slowTests.print_user_interaction
slowTests.open_files(slowTests.feature_files_path, "feature")
slowTests.get_scenarios_info
slowTests.run_scenarios
Dir.chdir(slowTests.current_directory)
reports = Reports.new
reports.generate_html_report_for_slow_tests(slowTests.scenarios_info)
