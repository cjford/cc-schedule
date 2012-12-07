Feature: View upcoming cruisers

Background: items in database
  Given the following lines exist:
  | id   | name | 
  | 1    | A    | 
  | 2    | B    | 
  | 3    | C    | 
  | 4    | D    | 

  Given the following locations exist:
  | id   | name       | 
  | 1    | Location1  | 
  | 2    | Location2  | 
  | 3    | Location3  | 
  | 4    | Location4  | 

  Given the following stops exist:
  | line_id   | location_id | hour | minute | monday | tuesday | wednesday | thursday | friday | saturday | sunday |
  | 1         | 1           | 23   | 59     | true   | true    | true      | true     | true   | true     | true   |
  | 2         | 2           | 23   | 59     | true   | true    | true      | true     | true   | true     | true   |
  | 3         | 3           | 23   | 59     | true   | true    | true      | true     | true   | true     | true   |
  | 4         | 4           | 23   | 59     | true   | true    | true      | true     | true   | true     | true   |

@javascript
Scenario: Load the home page
	Given I am on the home page
	Then I should see a table entry for "A"
  And I should see a table entry for "B"
  And I should see a table entry for "C"
  And I should see a table entry for "D"

@javascript
Scenario: Select location
	Given I am on the home page
	And I select "Location1" from "location_select"
	And I should see a table entry for "Location1"
