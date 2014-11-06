require_relative 'generic'

class MoodleLoginPage < GenericPage
  
  ADMIN_LOGIN = {username: 'moodle', password: 'soXy3zX2JTRwZCXw!'}
  STUDENT_LOGIN = {username: "user", password: "My.password1"}
  
  def login_as user_type
    @browser.a(text: 'Log in').click
    
    if user_type == :admin
      @browser.text_field(name: 'username').set(ADMIN_LOGIN[:username])
      @browser.text_field(name: 'password').set(ADMIN_LOGIN[:password])
    elsif user_type == :student
      @browser.text_field(name: 'username').set(STUDENT_LOGIN[:username])
      @browser.text_field(name: 'password').set(STUDENT_LOGIN[:password])
    else
      raise "User type can only be 'admin' or 'student'."
    end
    
    @browser.button(class: 'icon-submit fa fa-angle-right').click
    
    @browser.span(text: 'Site administration').wait_until_present
  end
end