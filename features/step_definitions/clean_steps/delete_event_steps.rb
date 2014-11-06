Given(/^I am on a calendar day with events$/) do
  @app.calendar.visit
  binding.pry # Only here until login method is finished
  # @app.login.login :user
end

When(/^I choose to delete the events$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should no longer see the event$/) do
  pending # express the regexp above with the code you wish you had
end