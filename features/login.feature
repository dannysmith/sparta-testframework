Feature: Successful Login
  
  Scenario: Adminstrative Login
    Given that I am on the Moodle Login Page to login as admin
    When I log into Moodle as an Admin
    Then I should be on the Admin Dashboard page
  
  Scenario: Student Login
    Given that I am on the login page to login as a student
    When I log into Moodle as an student
    Then I should be on the Student Dashboard page
    
  Scenario: Guest Login
    Given I am on the login page to login as a guest
    When I select the "Log in as guest" 
    Then I should be on the Guest Dashboard page
    
  Scenario: Unssucessful Login - Incorrect Password
    Given I am on the login page to login with an incorrect password
    When I attempt to login with an incorrect password
    Then an error should be shown
    And I am denied access and returned to the login page
    
  Scenario: Unssuccesful Login - Incorrect Username
    Given I am on the login page to login with an incorrect username
    When I attempt to login with an incorrect username
    Then an error message should be shown
    And returned to the login page and not logged in
  