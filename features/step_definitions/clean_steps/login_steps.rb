
Given(/^that I am on the Moodle Login Page to login as admin$/) do
  @app.login.visit

  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php") 
end

When(/^I log into Moodle as an Admin$/) do
  @app.login.admin

  expect(@browser.a(:title, "Admin User").text).to eq("Admin User") 
end

Then(/^I should be on the Admin Dashboard page$/) do
  expect(@browser.p(:id, "expandable_branch_71_siteadministration").text).to eq("Site administration")
  @app.login.logout
end




Given(/^that I am on the login page to login as a user$/) do
  @app.login.visit

  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php") 
end

When(/^I log into Moodle as an user$/) do
  @app.login.user
  
  expect(@browser.a(:title, "Aaron Muir").text).to eq("Aaron Muir")
end

Then(/^I should be on the user Dashboard page$/) do
  expect(@browser.text.include?("Site Admin")).to be false
  
  @app.login.logout
end




Given(/^I am on the login page to login as a guest$/) do
  @app.login.visit

  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php")
end

When(/^I select the Log in as a guest$/) do
  @app.login.guest
  
  expect(@browser.a(:title, "Guest user  ").text).to eq("Guest user") 
end

Then(/^I should be on the Guest Dashboard page$/) do
  expect(@browser.text.include?("Site Admin")).to be false
  
  @app.login.logout
end




Given(/^I am on the login page to login with an incorrect password$/) do
  @app.login.visit

  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php")
end

When(/^I attempt to login with an incorrect password$/) do
  @app.login.wrong_password
  
  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php")
end

Then(/^I am denied access and returned to the login page$/) do
  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php")
end

Given(/^I am on the login page to login with an incorrect username$/) do
  @app.login.visit
end

When(/^I attempt to login with an incorrect username$/) do
  @app.login.wrong_username
end

Then(/^returned to the login page and not logged in$/) do
  expect(@browser.url).to eq("http://unix.spartaglobal.com/moodle3/login/index.php")
end