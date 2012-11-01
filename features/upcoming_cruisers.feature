Feature: View upcoming cruisers

Scenario: Load the home page
	Given I am on the home page
	Then I should see a list of times and lines

Scenario: Change location
	Given I am on the home page
	When I change the location
	Then I should see a different list of times and lines
