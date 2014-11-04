class Moodle_Login < GenericPage
  
## Need to return to this to change it to use a yaml file to read in username and password fields.
  
  def login_user
    @browser.text_field(:name, "username").set("username")
    @browser.text_field(:name, "password").set("Abcd.1234")
    @browser.button(:class, "fa-angle-right").click
  end
  
  def login_admin
    @browser.text_field(:name, "username").set("moodle")
    @browser.text_field(:name, "password").set("soXy3zX2JTRwZCXw!")
    @browser.button(:class, "fa-angle-right").click
  end
  
#  def login_teacher
#    @browser.text_field(:name, "username").set("")
#    @browser.text_field(:name, "password").set("")
#    @browser.button(:class, "fa-angle-right").click
#  end
  
end