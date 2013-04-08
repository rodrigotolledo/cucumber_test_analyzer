#!/usr/bin/ruby -w

require "./extensive_tests_module"
require "./reports_module"
require "./file_handler"

extensiveTests = ExtensiveTests.new
extensiveTests.print_user_interaction
extensiveTests.open_files(extensiveTests.feature_files_path, "feature")
extensiveTests.get_scenarios_info
Dir.chdir(extensiveTests.current_directory)
reports = Reports.new
reports.generate_html_report_for_extensive_tests(extensiveTests.scenarios_info, extensiveTests.maximum_number_of_lines_user_input)
