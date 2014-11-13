Given(/^an event already exists$/) do
  @app.calendar.create_event
end

When(/^I update the event title$/) do
  @app.calendar.update_event_title
end

When(/^I update the event date$/) do
  @app.calendar.update_event_date
end

Then(/^the event title should be changed$/) do
  expect(@browser.text.include? "Updated event title").to eq(true)
end

Then(/^the event date should be changed$/) do
  expect(@browser.text.include? "#{(Date.today +1).month}").to eq(true)
end
