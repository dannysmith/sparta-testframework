Feature: Listing Courses
  
  Background:
    Given that I am logged in as a User
    
  @MDL-5 
  Scenario: Viewing a Course List
    When I am on MyHome page
    And I select all Courses
    Then I should see a list of all available courses
    When I select an available course
    Then I should be taken to that course page
    
