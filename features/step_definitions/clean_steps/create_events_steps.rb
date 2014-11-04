Given(/^I am logged in$/) do
  @app.login.login
end

When(/^I go to the create event page$/) do
  @app.events.visit_create 
end

When(/^enter valid event details$/) do
  @app.events.create
end

Then(/^it should appear on the calendar$/) do
  pending #expect calendar to show created events
end