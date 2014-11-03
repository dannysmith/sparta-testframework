Given(/^I am on a special page$/) do
  @app.test_page.visit
end

When /^I am testing$/ do
  binding.pry
end

Given /^I am on the homepage$/ do
  @app.home.visit
end
