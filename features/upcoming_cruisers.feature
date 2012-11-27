Feature: View upcoming cruisers

Scenario: Load the home page
	Given I am on the home page
	Then I should see a table of times and lines

Scenario: Select location
	Given I am on the home page
	When I select "Townhouses" from "Location"
	Then I should see a table of times and lines for "Townhouses"
