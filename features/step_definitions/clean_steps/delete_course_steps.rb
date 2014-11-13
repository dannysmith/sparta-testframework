And /^there is a course called Obsolete Course in the Software Testing category$/ do
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category
  @app.course_mgmt.goto_course_creation_form
  
  @app.course_creation.set_title :full, 'Obsolete Course Full'
  @app.course_creation.set_title :short, 'Obsolete Course Short'
  
  @app.course_creation.create_course
  
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category
  
  # just making sure that the course was created
  expect(@browser.a(text: 'Obsolete Course Full').exists?).to be true
end

And /^I choose to delete the Obsolete Course$/ do
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category
  @app.course_mgmt.goto_course 'Obsolete Course Full'
  
  @app.course_mgmt.click_on :delete
  
  @browser.input(value: 'Continue').click
end

Then /^it should be deleted$/ do
  expect(@browser.div(id: 'region-main').when_present.h2(index: 1).text).to include('Obsolete Course Short')
end

And /^it should not appear within the Software Testing category anymore$/ do
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category
  
  expect(@browser.a(text: 'Obsolete Course Full').exists?).to be false
end
