Before do
	@calculator = Calculator.new
end

Given /^I have entered (\d+) into the calculator (test1)$/ do |n|
	@calculator.push(n.to_i)
	pending "work in progress"
end

When /^I press (\w+) (test1)$/ do |op|
	@result = @calculator.op(op)
	sleep(1)
end

When /^I hit (\w+) (test1)$/ do |op|
	@result = @calculator.op(op)
	sleep(3)
end

When /^I click (\w+) (test1)$/ do |op|
	@result = @calculator.op(op)
	sleep(5)
end

Then /^the result should be (\d+) on the screen (test1)$/ do |n|
	@result.should == n.to_f
end


