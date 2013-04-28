#!/usr/bin/ruby -w

require "./time_frame_tests_module"
require "./reports_module"
require "./file_handler"

timeFrame = TimeFrameTests.new
timeFrame.print_user_interaction

slowTests = SlowTests.new
slowTests.print_user_interaction
slowTests.open_files(slowTests.feature_files_path, "feature")
slowTests.get_scenarios_info
slowTests.run_scenarios

timeFrame.verify_scenarios_info_time_frame(slowTests.scenarios_info)

Dir.chdir(slowTests.current_directory)
reports = Reports.new
reports.generate_html_report_for_time_frame_tests(timeFrame.time_frame_scenarios, timeFrame.time_frame_user_input)
