class Moodle_Login < HomePage
  
  def visit_login
    @browser.GoTo "http://unix.spartaglobal.com/moodle3/login/index.php"
  end
  
  def login_user
    @browser.a(:title, "Log in").click
    @browser.text_field(:name, "username").set("user")
    @browser.text_field(:name, "password").set("Mypassword1")
    @browser.button(:class, "fa-angle-right").click
  end
  
end