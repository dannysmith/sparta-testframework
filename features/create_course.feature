Feature: Course Creation

  Background:
    Given that I am logged in as a Teacher
    And I am in the Course and category management page
    
  @MDL-25
  Scenario: Creating a Course with a Topics format
    Given I select the Software Testing category
    When I choose to create a new course
    Then I should be sent to the Edit Course Settings page
    When I enter a Course Title
    And I enter a Course Summary
    And I set Topics as the Course Format
    Then the new course should be created
    And it should appear in the course list bearing its intended details
    
  @MDL-25 
  Scenario: Creating a Course with a Topics format
    Given I select the Software Testing category
    When I choose to create a new course
    Then I should be sent to the Edit Course Settings page
    When I enter a Course Title
    And I enter a Course Summary
    And I set Weekly as the Course Format
    Then the new course should be created
    And it should appear in the course list bearing its intended details
  
  @MDL-25 
  Scenario: Creating an Invisible Course
    Given I select the Software Testing category
    When I choose to create a new course
    Then I should be sent to the Edit Course Settings page
    When I enter a Course Title
    And I enter a Course Summary
    And I set the Course to be Invisible
    Then the new course should be created
    And only an Administrator or a Teacher can view it