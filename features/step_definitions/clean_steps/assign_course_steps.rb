And /^I create a new course within this category$/ do
  @app.course_mgmt.goto_course_creation_form
  
  @app.course_creation.set_title :full, POST_TITLE[:course_to_be_assigned][0][:full_title]
  
  @app.course_creation.set_title :short, POST_TITLE[:course_to_be_assigned][0][:short_title]
  
  @app.course_creation.create_course
end
  
Then /^this course should be successfully created$/ do
  @app.course_mgmt.visit
  
  @app.course_mgmt.expand_software_testing_category
  
  @app.course_mgmt.goto_course POST_TITLE[:course_to_be_assigned][0][:full_title]
end

And /^I successfully assign a user to be the Teacher for this newly created course$/ do
  @app.course_mgmt.visit
  
  @app.course_mgmt.expand_software_testing_category
  
  @app.course_mgmt.goto_course POST_TITLE[:course_to_be_assigned][0][:full_title]
  
  @app.course_mgmt.click_on :enrolled_users
  
  @app.enrolled_users.enrol 'Aaron Muir'
end

Then /^that user should have Teacher privileges settings for this course$/ do
  @app.enrolled_users.logout
  
  @app.login_page.login_as :student
  
  # Goto the course in which Aaron was assigned as a Teacher to 
  @browser.goto "#{EnvConfig.base_url}/course/view.php?id=77"
  
  expect(@browser.li(text: 'Turn editing on').exists?).to be true
end