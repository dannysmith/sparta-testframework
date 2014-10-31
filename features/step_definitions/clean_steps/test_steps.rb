When /^I am testing$/ do
  binding.pry
end

Given /^I am on the homepage$/ do
  @app.home.visit
end
