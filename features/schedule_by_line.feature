Feature: View cruiser schedules by line

Scenario: Navigate to line selection page
	Given I am on the home page
	When I click "Lines"
	Then I should be on the lines page

Scenario: Navigate to specific line page
	Given I am on the lines page
	When I click "A"
	Then I should be on the line page for "A"

Scenario: Click a line button on a location page.
	Given I am on the location page for "Townhouses"
	When I click "A"
	Then I should be on the line page for "A"

Scenario: Click a line button on the home page.
	Given I am on the home page
	When I click "A"
	Then I should be on the line page for "A"
