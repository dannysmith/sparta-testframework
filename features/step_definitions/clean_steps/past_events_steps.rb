Given(/^I am on the calendar page$/) do
  require 'pry'
  
  @app.home.visit
  binding.pry
  @app.calendar.visit_calendar
end

And(/^there is a past event$/) do
  @app.calendar.check_events
end

Then(/^I should be able to choose the past event$/) do
  @app.calendar.choose_past_events
end