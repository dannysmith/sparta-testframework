Feature: Past Events
	As an Teacher
	I want to be able to look at past events 
	So that I know what has been done previously
	
	- Past events are still listed on the calendar for its respective date 
	- Past events are still accessible to view in detail
	
	@MDL-19
	Scenario: View past events
		Given there is a past event
		When I go to the calendar page
		Then I should see a past events