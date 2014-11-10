Given /^that I am logged in as a student$/ do
  @app.login_page.login_as :student
end

When /^I enrol myself on a course$/ do
  @app.home.click_on_course POST_TITLE[:course_to_be_enrolled][0][:full_title]
  
  @app.course_enrollment.enrol
end
    
Then /^I should be fully enrolled on that course$/ do
  expect(@browser.a(href: /\w*self\/unenrolself\w*/)).to exist
end