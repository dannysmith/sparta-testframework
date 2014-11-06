Feature: Create Events
  As an event coordinator 
  I want to be able to create events
  So that I can invite people to them

  @MDL-6
  Scenario: Creating an event
    Given I am logged in 
    When I go to the create event page
    And enter valid event details
    Then it should appear on the calendar

 