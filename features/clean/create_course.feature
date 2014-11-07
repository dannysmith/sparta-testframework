Feature: Course Creation
    
  Background:
    Given that I am logged in as a Teacher
    
  @MDL-2 @clean
  Scenario: Creating a Course with a Topics format
    When I select the Software Testing category in the Course Management Page
    And I choose to create a new course
    Then I should be sent to the Edit Course Settings page
    When I enter the Full Title for the Course
    And I enter the Short Title for the Course
    And I set Topics as the Course Format
    Then the new course should be created
    And it should appear in the course list bearing its intended details
    
  @MDL-2 @clean
  Scenario: Creating a Course with a Topics format
    When I select the Software Testing category in the Course Management Page
    And I choose to create a new course
    Then I should be sent to the Edit Course Settings page
    When I enter the Full Title for the Course
    And I enter the Short Title for the Course
    And I set Weekly as the Course Format
    Then the new course should be created
    And it should appear in the course list bearing its intended details
  
  @MDL-2 @clean
  Scenario: Creating an Invisible Course
    When I select the Software Testing category in the Course Management Page
    And I choose to create a new course
    Then I should be sent to the Edit Course Settings page
    When I enter the Full Title for the Course
    And I enter the Short Title for the Course
    And I set the Course to be Invisible
    Then the new course should be created
    And only an Administrator or a Teacher can view it