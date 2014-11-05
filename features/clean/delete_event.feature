Feature: Delete Events
  As an event coordinator
  I want to be able to delete events
  So that out of date events can be deleted

  @MDL-44
  Scenario: Event deletion
    Given I am on a calendar day with events
    When I choose to delete the events
    Then I should no longer see the event
