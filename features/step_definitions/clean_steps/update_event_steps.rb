Given(/^I am logged in as admin$/) do
  @app.home.visit
  binding.pry
  #@app.login.login  
end

Given(/^an event already exists$/) do
  @app.calendar.create_event
end

Given(/^I am on the event page$/) do
  @app.calendar.visit
  @app.calendar.choose_past_events
end

When(/^I update the event title$/) do
  @app.calendar.update_event_title 
end

Then(/^the event title should be changed$/) do
  expect(@browser.text.include? "Updated event title").to eq(true)  
end

When(/^I update the event date$/) do
  @app.calendar.update_event_date
end

Then(/^the event date should be changed$/) do
  expect(@browser.text.include? "#{Date.today +1}").to eq(true)
end
