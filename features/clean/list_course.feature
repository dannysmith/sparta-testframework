Feature: Listing Courses
  
  Background:
    Given that I am logged in as a User
    And there is a course 
    
  @MDL-5 @clean
  Scenario: Viewing a Course List
    When I'm on the all course page
    Then I should see a list of all available courses
    And I should be able to see that course on the list
    
