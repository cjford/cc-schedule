Feature: View upcoming cruisers

Background: items in database

  Given the following lines exist:
  | id   | name | 
  | 1    | A    | 

  Given the following locations exist:
  | id   | name       | 
  | 1    | Townhouses | 

  Given the following stops exist:
  | line_id   | location_id | hour | minute | monday | tuesday | wednesday | thursday | friday | saturday | sunday |
  | 1         | 1           | 23   | 59     | true   | true    | true      | true     | true   | true     | true   |

Scenario: Load the home page
	Given I am on the home page
	Then I should see a table of times and lines

@javascript
Scenario: Select location
	Given I am on the home page
	When I select "Townhouses" from "locations_select"
	Then I should see a table of times and lines for "Townhouses"
