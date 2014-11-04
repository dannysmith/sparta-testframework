Feature: Past Events
	As an Teacher
	I want to be able to look at past events 
	So that I know what has been done previously
	
	- Past events are still listed on the calendar for its respective date 
	- Past events are still accessible to view in detail
	
	@MDL-19
	Scenario: View past events
		Given I am on the calendar page
		And there is a past event
		Then I should see the past event