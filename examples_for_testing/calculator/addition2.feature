Feature: Addition
	In order to avoid silly mistakes
	As a math idiot
	I want to be told the sum of two numbers

	Scenario: Add two numbers FILE2 SC1
		Given I have entered 50 into the calculator



		And I have entered 70 into the calculator
		When I hit add
		Then the result should be 120 on the screen

	Scenario: Add two numbers FILE2 SC2
		Given I have entered 50 into the calculator
		And I have entered 70 into the calculator
		When I press add
		Then the result should be 120 on the screen

	Scenario: Add two numbers FILE2 SC3
		Given I have entered 50 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		And I have entered 70 into the calculator
		When I click add
		Then the result should be 120 on the screen
