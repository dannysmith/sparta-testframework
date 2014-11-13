# Used for registering people and checking registration email has been sent
#-------------------------------------------------------------------------------------------------------------
# Author:      Aaron Muir
# Modified:    2014-12-11
#-------------------------------------------------------------------------------------------------------------
class RegistrationPage < GenericPage

  #refactor into user.yml file
  EMAIL = "testingcircle.test@gmail.com"
  PASSWORD = "Derek.password1"

  def visit
    @browser.goto "#{EnvConfig.base_url}/login/signup.php"
  end

  def complete_registration
    @browser.text_field(:id, "id_username").set "derek"
    @browser.text_field(:id, "id_password").set PASSWORD
    @browser.text_field(:id, "id_email").set EMAIL
    @browser.text_field(:id, "id_email2").set EMAIL
    @browser.text_field(:id, "id_firstname").set "Derek"
    @browser.text_field(:id, "id_lastname").set "Derekson"

    @browser.button(:id, "id_submitbutton").click  
  end

  def login_email
    @browser.goto "mail.google.com"
    @browser.text_field(:id, "Email").set EMAIL
    @browser.text_field(:id, "Passwd").set PASSWORD
    @browser.button(:id, "signIn").click
  end

  def email_load_time
    Watir::Wait.until(EMAIL_WAIT){@browser.text.include?("Admin User")}
  end
end
