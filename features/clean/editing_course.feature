Feature: Course Editing

  Background:
    Given that I am logged in as a Teacher
  
  @MDL-18
  Scenario: Editing a Course's short title
    When I select the Software Testing category in the Course Management Page
    And I choose to Edit a Course's short title
    Then the course's short title should then be updated