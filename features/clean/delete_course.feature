Feature: Deleting a Course

  Background:
    Given that I am logged in as a Teacher
    And there is a course called Obsolete Course in the Software Testing category
    
  @MDL-15 @clean
  Scenario: Deleting an Obsolete Course
    When I select the Software Testing category in the Course Management Page
    And I choose to delete the Obsolete Course
    Then it should be deleted
    And it should not appear within the Software Testing category anymore