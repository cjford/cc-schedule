Feature: Filter stop results based on their line

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
Scenario: Select all lines
  Given I am on the home page
  When I click "Filter"
  And I check "A"
  And I check "B"
  And I check "C"
  And I check "D"
  And I click "Save changes"
  Then I should be on the home page
  And I should see a table entry for "Location1"
  And I should see a table entry for "Location2"
  And I should see a table entry for "Location3"
  And I should see a table entry for "Location4"

@javascript
Scenario: Select no lines
  Given I am on the home page
  When I click "Filter"
  And I uncheck "A"
  And I uncheck "B"
  And I uncheck "C"
  And I uncheck "D"
  And I click "Save changes"
  Then I should be on the home page
  And I should not see a table entry for "Location1"
  And I should not see a table entry for "Location2"
  And I should not see a table entry for "Location3"
  And I should not see a table entry for "Location4"

@javascript
Scenario: Select some lines
  Given I am on the home page 
  When I click "Filter"
  And I check "A"
  And I uncheck "B"
  And I check "C"
  And I uncheck "D"
  And I click "Save changes"
  Then I should be on the home page
  And I should see a table entry for "Location1"
  And I should not see a table entry for "Location2"
  And I should see a table entry for "Location3"
  And I should not see a table entry for "Location4"
