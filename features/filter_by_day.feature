Feature: Filter stop results based on their day

Background: items in database
  Given the following lines exist:
  | id   | name | 
  | 1    | A    | 
  | 2    | B    | 

  Given the following locations exist:
  | id   | name       | 
  | 1    | Location1  | 
  | 2    | Location2  | 

  Given the following stops exist:
  | line_id   | location_id | hour | minute | monday | tuesday | wednesday | thursday | friday | saturday | sunday |
  | 1         | 1           | 23   | 59     | true   | false   | false     | false    | false  | false    | false  |
  | 2         | 1           | 23   | 59     | false  | true    | false     | false    | false  | false    | false  |
  | 1         | 2           | 23   | 59     | false  | true    | false     | false    | false  | false    | false  |
  | 2         | 2           | 23   | 59     | true   | false   | false     | false    | false  | false    | false  |

@javascript
Scenario: Select monday stops on lines page
  Given today is tuesday
  And I am on the lines page for "A"
  And I select "Monday" from "line_day_select"
  Then I should see a table entry for "Location1"
  And I should not see a table entry for "Location2"

@javascript
Scenario: Select tuesday stops on lines page
  Given today is monday
  And I am on the lines page for "A"
  And I select "Tuesday" from "line_day_select"
  Then I should see a table entry for "Location2"
  And I should not see a table entry for "Location1"

@javascript
Scenario: Select monday stops on locations page
  Given today is tuesday
  And I am on the locations page for "Location1"
  And I select "Monday" from "location_day_select"
  Then I should see a table entry for "A"
  And I should not see a table entry for "B"

@javascript
Scenario: Select tuesday stops on locations page
  Given today is monday
  And I am on the locations page for "Location1"
  And I select "Tuesday" from "location_day_select"
  Then I should see a table entry for "B"
  And I should not see a table entry for "A"
