Feature: Listing Courses
  
  Background:
    Given that I am logged in as a User
    
  @MDL-5 @clean
  Scenario: Viewing a Course List
    When I'm on the all course page
    Then I should see a list of all available courses
    And I select an available course
    Then I should be taken to that course page
    
