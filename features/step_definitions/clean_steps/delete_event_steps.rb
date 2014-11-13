#Previous steps made past_events_steps
Then /^I should be able to delete the event$/ do
  @app.calendar.delete_event
end
