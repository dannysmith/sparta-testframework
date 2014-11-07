Feature: Delete Events
  As an event coordinator
  I want to be able to delete events
  So that out of date events can be deleted

  @MDL-20 @wip
  Scenario: Event deletion
    Given I am on the calendar page
	Then I should be able to choose the past event
	Then I should be able to delete the event
	