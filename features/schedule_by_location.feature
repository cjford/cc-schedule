Feature: View cruiser schedules by location

Scenario: Navigate to location selection page
	Given I am on the home page
	When I click "Locations"
	Then I should be on the locations page

Scenario: Navigate to specific location page
	Given I am on the locations page
	When I click "Townhouses"
	Then I should be on the locations page for "Townhouses" 

Scenario: Click a location name on a line page
	Given I am on the lines page for "A"
	When I click "Townhouses"
	Then I should be on the locations page for "Townhouses"
