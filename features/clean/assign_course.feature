Feature: Assigning a Course

  Background:
    Given that I am logged in as a Teacher
  
  #CI error - cannot find element in DOM
  @MDL-47 @wip
  Scenario: Assigning a Course to myself
    When I select the Software Testing category in the Course Management Page
    And I create a new course within this category
    And I successfully assign a user to be the Teacher for this newly created course
    Then that user should have Teacher privileges settings for this course