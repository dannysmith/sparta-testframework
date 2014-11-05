require_relative 'generic'

class MoodleLogin < GenericPage
  
  
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
end