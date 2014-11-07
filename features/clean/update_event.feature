Feature: Updating Events
  As an event coordinator
  I want the ability to update event details
  So that I can change the event if needed

  Background: 
    Given I am logged in
    And an event already exists

  @MDL-37 @wip
  Scenario: Edit event title
    Given I am on the event page
    When I change the event title
    And save the changes
    Then the event title should be changed

  @MDL-37 @wip
  Scenario: Edit event description
    Given I am on the event page
    When I change the event description
    And save the changes
    Then the event description should be changed

  @MDL-37 @wip
  Scenario: Edit event date
    Given I am on the event page
    When I change the event date
    And save the changes
    Then the event date should be changed