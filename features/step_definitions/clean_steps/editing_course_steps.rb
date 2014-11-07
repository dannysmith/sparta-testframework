And /^I choose to Edit a Course's short title$/ do
  @app.course_mgmt.goto_course POST_TITLE[:topics][0][:full_title]
  
  @app.course_mgmt.click_on :edit

  @app.course_editing.change_course_short_title_to POST_TITLE[:edited_title][0][:new_short_title]
end

Then /^the course's short title should then be updated$/ do
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category

  @app.course_mgmt.goto_course POST_TITLE[:topics][0][:full_title]

  expect(@browser.div(class: /\w*shortname/).when_present.text).to include(POST_TITLE[:edited_title][0][:new_short_title])
end
