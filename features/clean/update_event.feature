Feature: Updating Events
  As an event coordinator
  I want the ability to update event details
  So that I can change the event if needed

  @MDL-37
  Scenario: Edit events
    Given I am logged in 
    And an event already exists
    When I update the event title
    And I update the event date
    Then the event title should be changed
    And the event date should be changed
