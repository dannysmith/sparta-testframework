 Feature: Deleting Courses
  As an administrator 
  I want to delete obsolete courses
  So that they cannot be seen anymore

  - Confirmation box should appear before deletion

  Background:
    Given I am logged in
    And a course already exists

  @MDL-31
  Scenario: Deleting a Course
    Given I am on the "Course and category management" page
    When I choose a course
    And I select the delete option
    Then the course should no longer exist
