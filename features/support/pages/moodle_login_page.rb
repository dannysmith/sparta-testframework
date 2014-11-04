require_relative 'generic'

class MoodleLogin < GenericPage
  
  
  def login_user
    @browser.text_field(:name, "username").set(CREDENTIALS[1][:user])
    @browser.text_field(:name, "password").set(CREDENTIALS[1][:password])
    @browser.button(:class, "fa-angle-right").click
  end
  
  def login_admin
    @browser.text_field(:name, "username").set(CREDENTIALS[:admin][0][:user])
    @browser.text_field(:name, "password").set(CREDENTIALS[:admin][0][:password])
    @browser.button(:class, "fa-angle-right").click
  end
  
  def login_guest
    @browser.button(:value, "Log in as a guest").click
  end  
end