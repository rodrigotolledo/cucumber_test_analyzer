Before do
	@calculator = Calculator.new
end

Given /^I have entered (\d+) into the calculator (test2)$/ do |n|
	@calculator.push(n.to_i)
end

When /^I press (\w+) (test2)$/ do |op|
	@result = @calculator.op(op)
	sleep(1)
end

When /^I hit (\w+) (test2)$/ do |op|
	@result = @calculator.op(op)
	sleep(3)
end

When /^I click (\w+) (test2)$/ do |op|
	@result = @calculator.op(op)
	sleep(5)
end

Then /^the result should be (\d+) on the screen (test2)$/ do |n|
	@result.should == n.to_f
end


