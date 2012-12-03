Feature: View upcoming cruisers

Scenario: Load the home page
	Given I am on the home page
	Then I should see a table of times and lines

@javascript
Scenario: Select location
	Given I am on the home page
	When I select "Townhouses" from "locations_select"
	Then I should see a table of times and lines for "Townhouses"
