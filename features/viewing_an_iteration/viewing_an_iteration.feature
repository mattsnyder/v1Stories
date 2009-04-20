Feature: Viewing an iteration from Version One
As Jason
I want to get all stories in an iteration from Version One
So I can print them

	Scenario: Stories show on page
	Given an iteration with Number "1"
	And a story titled "print by batch" is in the iteration
	And a story titled "print individual cars" is in the iteration
	And a story titled "support 4x6 cards" is in the iteration
	When I go to Iteration 1
	Then I should see "print by batch"
	And I should see "print individual cars"
	And I should see "support 4x6 cards"