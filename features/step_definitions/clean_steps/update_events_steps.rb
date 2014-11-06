Given(/^an event already exists$/) do
  create_event 
end

Given(/^I am on the event page$/) do
  choose_past_event
end

When(/^I update the event title$/) do
  update_event_title 
end


Then(/^the event title should be changed$/) do
  expect(@browser.text.include?).to eq(true)  
end

When(/^I update the event date$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the event date should be changed$/) do
  pending # express the regexp above with the code you wish you had
end
