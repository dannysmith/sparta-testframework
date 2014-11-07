Then(/^I should be able to delete the event$/) do
  @app.calendar.delete_event
  expect(@events_list_current_length > @events_list_deleted_length).to be(true)
end
