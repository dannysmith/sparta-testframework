And /^I choose to Edit a Course's short title$/ do
  @app.course_mgmt.goto_course POST_TITLE[:topics][0][:full_title]
  
  #@browser.a(text: 'Edit').when_present.click - this works but it doesn't so I was forced to do the following..
  
  @browser.div(class: 'listing-actions course-detail-listing-actions').wait_until_present
  # course_options_list = @browser.div(class: 'listing-actions course-detail-listing-actions').wait_until_present
  # doesn't work either
    
  # so what i did was took the div wrapper for all the available options for a course
  course_options_list = @browser.div(class: 'listing-actions course-detail-listing-actions')
  # took all the available options for a course
  course_options = course_options_list.as
  # then took the edit option which is the 2nd one in the options list
  course_edit_option = course_options[1]
  # then I clicked it
  course_edit_option.click

  @app.course_editing.change_course_short_title_to POST_TITLE[:edited_title][0][:new_short_title]
end

Then /^the course's short title should then be updated$/ do
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category

  @app.course_mgmt.goto_course POST_TITLE[:topics][0][:full_title]

  expect(@browser.div(class: /\w*shortname/).when_present.text).to include(POST_TITLE[:edited_title][0][:new_short_title])
end
