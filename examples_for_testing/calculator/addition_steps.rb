Before do
	@calculator = Calculator.new
end

Given /^I have entered (\d+) into the calculator$/ do |n|
	@calculator.push(n.to_i)
end

When /^I press (\w+)$/ do |op|
	@result = @calculator.op(op)
	sleep(1)
end

When /^I hit (\w+)$/ do |op|
	@result = @calculator.op(op)
	sleep(3)
end

When /^I click (\w+)$/ do |op|
	@result = @calculator.op(op)
	sleep(2)
end

Then /^the result should be (\d+) on the screen$/ do |n|
	@result.should == n.to_f
end


