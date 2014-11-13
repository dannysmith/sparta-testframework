class LoginPage < GenericPage
  
  def visit
    @browser.goto "#{EnvConfig.base_url}login/index.php"
  end
  
  def login_as user_type
    visit
    
    if user_type == :admin
      @browser.text_field(name: 'username').set(CREDENTIALS[:admin][0][:user])
      @browser.text_field(name: 'password').set(CREDENTIALS[:admin][0][:password])
      
      @browser.button(class: 'icon-submit fa fa-angle-right').click
    elsif user_type == :student
      @browser.text_field(name: 'username').set(CREDENTIALS[:normal][0][:user])
      @browser.text_field(name: 'password').set(CREDENTIALS[:normal][0][:password])
      
      @browser.button(class: 'icon-submit fa fa-angle-right').click
    elsif user_type == :guest
      @browser.button(:value, "Log in as a guest").click
    else
      raise "User type can only be 'admin' or 'student'."
    end
    
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
  
end
