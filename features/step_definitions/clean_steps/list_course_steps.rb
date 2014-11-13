Given /^that I am logged in as a User$/ do
  @app.login_page.login_as :admin
end

Given /^there is a course$/ do
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category
  @app.course_mgmt.goto_course_creation_form
  @app.course_creation.create_course full_title: "Test course", short_title: "TCC", type: "weekly"
  @app.course_creation.confirm_course
end

When /^I'm on the all course page$/ do
  @app.home.visit
end
#
Then /^I should see a list of all available courses$/ do
  expect(@browser.div(id: 'frontpage-course-list')).to exist
end

And /^I should be able to see that course on the list$/ do
  expect(@browser.text.include? "Test course").to be true
end
