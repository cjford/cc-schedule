Feature: View cruiser schedules by location

Background: items in database
  Given the following lines exist:
  | id   | name | 
  | 1    | A    | 

  Given the following locations exist:
  | id   | name       | 
  | 1    | Location1 | 

  Given the following stops exist:
  | line_id   | location_id | hour | minute |
  | 1         | 1           | 12   | 0      |

Scenario: Navigate to location selection page
	Given I am on the home page
	When I click "Locations"
	Then I should be on the locations page

Scenario: Navigate to specific location page
	Given I am on the locations page
	When I click "Location1"
	Then I should be on the locations page for "Location1" 

Scenario: Click a location name on a line page
	Given I am on the lines page for "A"
	When I click "Location1"
	Then I should be on the locations page for "Location1"
