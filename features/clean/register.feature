Feature: Registering on moodle
  As a student
  I want to be able to register myself
  So that I can enroll on courses

  @MDL-21 
  Scenario: 
    Given I am on the registration page
    When I fill in all the mandatory registration fields
    Then I should receive email confirmation
