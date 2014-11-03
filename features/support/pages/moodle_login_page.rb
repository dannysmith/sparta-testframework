class Moodle_Login
  
  def login_button
    @browser.a(:title, "Log in").click
  end
  
  def login_user
    @browser.text_field(:name, "username").set("user")
    @browser.text_field(:name, "password".set("Mypassword1£")
    @browser.button(:class, "fa-angle-right").click
  end
  
  def 
  
end