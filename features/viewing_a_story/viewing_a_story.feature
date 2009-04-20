Feature: Viewing a story from Version One
As Jason
I want to get a story from Version One
So I can print it

	Scenario: Story shows on page
	Given a story with Number "1"
	And Title "Dummy Story"
	And Theme "Great theme"
	And Description "Another description that is awesome"
	And Owner "Jason"
	When I ask for the story to be shown
	Then I can see the story's information
