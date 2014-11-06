Feature: Updating Events
  As an event coordinator
  I want the ability to update event details
  So that I can change the event if needed

  @MDL-37
  Scenario: Edit event details
    Given I am logged in as admin
    And an event already exists
    And I am on the event page
    When I update the event title
    And I update the event date
    Then the event title should be changed
