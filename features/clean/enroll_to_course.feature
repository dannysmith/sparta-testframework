Feature: Enrolling on a course

  @MDL-14
  Scenario: A student enrolling himself on a course
    Given that I am logged in as a student
    When I enrol myself on a course
    Then I should be fully enrolled on that course