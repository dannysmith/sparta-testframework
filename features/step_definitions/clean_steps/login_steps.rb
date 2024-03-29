Given /^that I am on the Moodle Login Page to login as admin$/ do
  @app.login_page.visit

  expect(@browser.url).to eq("#{EnvConfig.base_url}login/index.php") 
end

When /^I log into Moodle as an Admin$/ do
  @app.login_page.login_as :admin
  expect(@app.dashboard.admin).to eq("Admin User") 
end

Then /^I should be on the Admin Dashboard page$/ do
  expect(@app.dashboard.admin_panel).to eq("Site administration")
  @app.login_page.logout
end

Given /^that I am on the login page to login as a user$/ do
  @app.login_page.visit

  expect(@browser.url).to eq("#{EnvConfig.base_url}login/index.php") 
end

When /^I log into Moodle as an user$/ do
  @app.login_page.login_as :student
  
  expect(@app.dashboard.user).to eq("Aaron Muir")
end

Then /^I should be on the user Dashboard page$/ do
  expect(@browser.text.include?("Site Admin")).to be false
  
  @app.login_page.logout
end

Given /^I am on the login page to login as a guest$/ do
  @app.login_page.visit

  expect(@browser.url).to eq("#{EnvConfig.base_url}login/index.php")
end

When /^I choose to login as a guest$/ do
  @app.login_page.login_as :guest
  
  expect(@app.dashboard.guest).to eq("Guest user") 
end

Then /^I should be on the Guest Dashboard page$/ do
  expect(@app.dashboard.site_admin).to be false
  
  @app.login_page.logout
end

Given /^I am on the login page to login with an incorrect password$/ do
  @app.login_page.visit

  expect(@browser.url).to eq("#{EnvConfig.base_url}login/index.php")
end

When /^I attempt to login with an incorrect password$/ do
  @app.login_page.wrong_password
  
  expect(@browser.url).to eq("#{EnvConfig.base_url}login/index.php")
end

Then /^I am denied access and returned to the login page$/ do
  expect(@browser.url).to eq("#{EnvConfig.base_url}login/index.php")
end

Given /^I am on the login page to login with an incorrect username$/ do
  @app.login_page.visit
end

When /^I attempt to login with an incorrect username$/ do
  @app.login_page.wrong_username
end

Then /^returned to the login page and not logged in$/ do
  expect(@browser.url).to eq("#{EnvConfig.base_url}login/index.php")
end
