Feature: Enrolling onto a course 
  As a student
  I want to enrol myself on a course 
  So that I can start studying its course content

  @MDL-14
  Scenario: User enrollment
    Given I log into moodle as a user
    When I enrol on a course
    Then I should be able to see course materials