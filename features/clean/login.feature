Feature: Logging into Moodle
  
  @MDL-1 @clean
  Scenario: Admin Login
    Given that I am on the Moodle Login Page to login as admin
    When I log into Moodle as an Admin
    Then I should be on the Admin Dashboard page
  
  @MDL-1 @clean
  Scenario: User Login
    Given that I am on the login page to login as a user
    When I log into Moodle as an user
    Then I should be on the user Dashboard page
  
  @MDL-1 @clean
  Scenario: Guest Login
    Given I am on the login page to login as a guest
    When I choose to login as a guest
    Then I should be on the Guest Dashboard page
  
  @MDL-1 @clean
  Scenario: Unsuccessful Login
    Given I am on the login page to login with an incorrect password
    When I attempt to login with an incorrect password
    Then I am denied access and returned to the login page
    Given I am on the login page to login with an incorrect username
    When I attempt to login with an incorrect username
    Then I am denied access and returned to the login page
  