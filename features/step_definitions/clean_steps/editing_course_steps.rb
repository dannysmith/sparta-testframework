And /^I choose to Edit a Course's short title$/ do
  @app.course_mgmt.goto_course TOPICS_POST[:full_title]
  
  @app.course_mgmt.click_on :edit

  @app.course_editing.change_course_short_title_to "EDITED TOPICS SHORT TITLE TEST"
end

Then /^the course's short title should then be updated$/ do
  @app.course_mgmt.visit
  
  @app.course_mgmt.expand_software_testing_category

  @app.course_mgmt.goto_course TOPICS_POST[:full_title]

  expect(@browser.div(class: /\w*shortname/).when_present.text).to include('EDITED TOPICS SHORT TITLE TEST')
end
