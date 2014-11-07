# NEEDS TO BE REFACTORED
class MoodleLoginPage < GenericPage
  
  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle3/login/index.php"
  end
  
  def login_as user_type
    visit
    
    if user_type == :admin
      @browser.text_field(name: 'username').set(CREDENTIALS[:admin][0][:user])
      @browser.text_field(name: 'password').set(CREDENTIALS[:admin][0][:password])
    elsif user_type == :student
      @browser.text_field(name: 'username').set(CREDENTIALS[:normal][0][:user])
      @browser.text_field(name: 'password').set(CREDENTIALS[:normal][0][:password])
    elsif user_type == :guest
      @browser.button(:value, "Log in as a guest").click
      @browser.h2(class: 'marketingheader').wait_until_present
    else
      raise "User type can only be 'admin' or 'student'."
    end
    
    @browser.button(class: 'icon-submit fa fa-angle-right').click
    
    @browser.h2(class: 'marketingheader').wait_until_present
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
