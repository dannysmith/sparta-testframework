
Given(/^that I am on the Moodle Login Page to login as admin$/) do
  @app.home.visit
  @app.home.visit_login

  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php") 
end

When(/^I log into Moodle as an Admin$/) do
  @app.login.login_admin

  expect(@browser.a(:title, "Admin User").text).to eq("Admin User") 
end

Then(/^I should be on the Admin Dashboard page$/) do
  expect(@browser.p(:id, "expandable_branch_71_siteadministration").text).to eq("Site administration")
  
  @app.home.logout
end




Given(/^that I am on the login page to login as a student$/) do
  @app.home.visit
  @app.home.visit_login

  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php") 
end

When(/^I log into Moodle as an student$/) do
  @app.login.login_user
  
  expect(@browser.a(:title, "Aaron Muir").text).to eq("Aaron Muir")
end

Then(/^I should be on the Student Dashboard page$/) do
  expect(@browser.text.include?("Site Admin")).to be false
  
  @app.home.logout
end




Given(/^I am on the login page to login as a guest$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I select the "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should be on the Guest Dashboard page$/) do
  pending # express the regexp above with the code you wish you had
end




Given(/^I am on the login page to login with an incorrect password$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I attempt to login with an incorrect password$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^an error should be shown$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I am denied access and returned to the login page$/) do
  pending # express the regexp above with the code you wish you had
end




Given(/^I am on the login page to login with an incorrect username$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I attempt to login with an incorrect username$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^an error message should be shown$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^returned to the login page and not logged in$/) do
  pending # express the regexp above with the code you wish you had
end