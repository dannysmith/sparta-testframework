Feature: Successful Login
  
  Scenario: Adminstrative Login
    Given I have administrator credentials
    When I log into Moodle as an Admin
    Then I should be logged in
    And On the Admin Dashboard page
  
  Scenario: Teacher Login
    Given I have teacher credentials
    When I log into Moodle as an teacher
    Then I should be logged in
    And On the teacher Dashboard page
  
  Scenario: Student Login
    Given I have student credentials
    When I log into Moodle as an Admin
    Then I should be logged in
    And On the Student Dashboard page
    
  Scenario: Guest Login
    Given I am on the login page
    When I select the "Log in as guest" 
    Then I should be logged in
    And On the Guest Dashboard page
    
  Scenario: Unssucessful Login - Incorrect Password
    Given I am using incorrect password and correct username
    When I attempt to login
    Then an error should be shown
    And I am denied access
    
  Scenario: Unssuccesful Login - Incorrect Username
    Given I am using incorrect username and correct password
    When I attempt to login
    Then an error should be shown
    And I am denied access
    
  
  
  
  
  