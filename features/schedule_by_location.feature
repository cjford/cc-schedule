Feature: View cruiser schedules by location

Scenario: Navigate to location selection page
	Given I am on the home page
	When I click "Locations"
	Then I should be on the location page

Scenario: Navigate to specific location page
	Given I am on the location page
	When I click "Townhouses"
	Then I should be on the location page for "Townhouses" 

Scenario: Click a location name on a line page
	Given I am on the line page for "A"
	When I click "Townhouses"
	Then I should be on the location page for "Townhouses"
