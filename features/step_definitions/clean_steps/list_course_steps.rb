Given(/^that I am logged in as a User$/) do
  @app.login_page.login_as :student
  
  expect(@app.dashboard.user).to eq("Aaron Muir")
end

When(/^I'm on the all course page$/) do
  @app.all_course_page.visit
end

Then(/^I should see a list of all available courses$/) do
  expect(@browser.text.include?("Miscellaneous")).to be true
  # course_category_tree clearfix category-browse category-browse-0
end

Then(/^I select an available course$/) do
  @browser.goto "#{EnvConfig.base_url}/course/view.php?id=52"
end

Then(/^I should be taken to that course page$/) do
  expect(@browser.url.should == "#{EnvConfig.base_url}/course/view.php?id=52")
end