Given(/^I am on the registration page$/) do
  @app.registration.visit
end

When(/^I fill in all the mandatory registration fields$/) do
  @app.registration.complete_registration
end

Then(/^I should receive email confirmation$/) do
  @app.registration.check_registration
  @app.registration.email_load_time
  expect(@browser.text.include? "Admin User").to eq true
end
