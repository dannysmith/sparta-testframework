Feature: Updating Events
  As an event coordinator
  I want the ability to update event details
  So that I can change the event if needed

  Background: 
    Given I am logged in
    And an event already exists

  @MDL-37
  Scenario: Edit event title
    Given I am on the event page
    When I update the event title
    Then the event title should be changed

  @MDL-37
  Scenario: Edit event date
    Given I am on the event page
    When I update the event date
    Then the event date should be changed 