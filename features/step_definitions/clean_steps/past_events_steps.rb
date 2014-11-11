Given /^I am on the calendar page$/ do
  @app.login_page.login_as :student
  @app.calendar.visit
end

And /^there is a past event$/ do
  @app.calendar.check_events
end

Then /^I should be able to choose the past event$/ do
  @app.calendar.choose_past_events
end
