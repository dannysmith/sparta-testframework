Given /^I am logged in$/ do
  @app.login_page.login_as :admin
end

When /^I go to the create event page$/ do
  @app.calendar.visit
end

When /^enter valid event details$/ do
  @app.calendar.create_event
end

Then /^it should appear on the calendar$/ do
  @app.calendar.visit
  expect(@browser.text.include? "Test Event").to eq(true)
end
