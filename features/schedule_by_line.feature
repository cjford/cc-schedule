Feature: View cruiser schedules by line

Background: items in database
  Given the following lines exist:
  | id   | name | 
  | 1    | A    | 

  Given the following locations exist:
  | id   | name       | 
  | 1    | Townhouses | 

  Given the following stops exist:
  | line_id   | location_id | hour | minute |
  | 1         | 1           | 12   | 0      |

Scenario: Navigate to line selection page
	Given I am on the home page
	When I click "Lines"
	Then I should be on the lines page

Scenario: Navigate to specific line page
	Given I am on the lines page
	When I click "A"
	Then I should be on the lines page for "A"

Scenario: Click a line button on a location page.
	Given I am on the locations page for "Townhouses"
	When I click "A"
	Then I should be on the lines page for "A"

Scenario: Click a line button on the home page.
	Given I am on the home page
	When I click "A"
	Then I should be on the lines page for "A"
