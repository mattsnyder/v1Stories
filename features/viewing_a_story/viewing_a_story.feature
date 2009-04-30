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
	When I go to Story 1
	Then I should see "1"
	And I should see "Dummy Story"
	And I should see "Great theme"
	And I should see "Another description that is awesome"
	And I should see "Jason"
	
	Scenario: Long descriptions are truncated
	Given a story with Number "1"
	And Description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ornare ultricies nisi. Sed condimentum, mauris tempus rutrum cursus, elit odio pulvinar ante, sed vehicula nisi leo non risus. Aliquam erat volutpat. Cras venenatis euismod orci. Suspendisse in"
	When I go to Story 1
	Then I should not see ". Suspendisse in"
	And I should see ". Suspen..."
