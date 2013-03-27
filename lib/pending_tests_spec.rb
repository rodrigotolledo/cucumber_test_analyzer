require "./pending_tests_module"
require "./capture_output"

describe PendingTests do

	before(:each) do
		@pendingTests = PendingTests.new
		@captureOutput = CaptureOutput.new
	end

	it "should open step definitions files successfully" do
		output = @captureOutput.capture_stdout { @pendingTests.open_step_definitions_files("/Users/Thoughtworks/Documents/my_stuff/TCC2-here-we-go/test_app/step_definitions") }
		output.should == "Step Definitions files to be analyzed: [\"erb_example.rb\", \"step_definitions_example1.rb\", \"step_definitions_example2.rb\", \"step_definitions_example3.rb\"].\n"
		#output.should == "Step Definitions files to be analyzed: erb_example.rbstep_definitions_example1.rbstep_definitions_example2.rbstep_definitions_example3.rb.\n"
	end

	it "should verify how many tests exist and find 6" do
		pending "working in progress"
		amount_of_existing_tests = @pendingTests.verify_how_many_tests_exist
		amount_of_existing_tests.should == 6
	end
end
