require_relative 'generic'

class MoodleLogin < GenericPage
  
  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle3/login/index.php"
  end

# Another method used to log in. Not used because it would add more into the step definition.
#  @app.login.user CREDENTIALS[:user][0][:user], CREDENTIALS[:user][0][:password]
#  
#  def login username, password
#    @browser.text_field(:name, "username").set(username)
#    @browser.text_field(:name, "password").set(password)
#    @browser.button(:class, "fa-angle-right").click
#  end
  
  def user
    @browser.text_field(:name, "username").set(CREDENTIALS[:normal][0][:user])
    @browser.text_field(:name, "password").set(CREDENTIALS[:normal][0][:password])
    @browser.button(:class, "fa-angle-right").click
  end
  
  def admin
    @browser.text_field(:name, "username").set(CREDENTIALS[:admin][0][:user])
    @browser.text_field(:name, "password").set(CREDENTIALS[:admin][0][:password])
    @browser.button(:class, "fa-angle-right").click
  end
  
  def guest
    @browser.button(:value, "Log in as a guest").click
  end  
  
  def wrong_password
    @browser.text_field(:name, "username").set(CREDENTIALS[:incorrect_password][0][:user])
    @browser.text_field(:name, "password").set(CREDENTIALS[:incorrect_password][0][:password])
    @browser.button(:class, "fa-angle-right").click
  end
  
  
  def wrong_username
    @browser.text_field(:name, "username").set(CREDENTIALS[:incorrect_username][0][:user])
    @browser.text_field(:name, "password").set(CREDENTIALS[:incorrect_username][0][:password])
    @browser.button(:class, "fa-angle-right").click
  end
  
  def logout
    @browser.goto "http://unix.spartaglobal.com/moodle3/login/logout.php"
    @browser.div(:class, "singlebutton").button.click
  end
end