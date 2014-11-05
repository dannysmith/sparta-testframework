Given(/^I am on the calendar page$/) do
  @app.calendar.visit
  binding.pry # Only here until login method is finished
  # @app.login.login :user
end

And(/^there is a past event$/) do
  @app.calendar.check_events
end

Then(/^I should be able to choose the past event$/) do
  @app.calendar.choose_past_events
end