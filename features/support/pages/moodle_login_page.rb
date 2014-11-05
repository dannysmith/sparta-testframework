require_relative 'generic'

class MoodleLoginPage < GenericPage
  
  LOGIN = {username: "moodle", password: "soXy3zX2JTRwZCXw!"}

  def login
    @browser.a(text: 'Log in').click
    @browser.text_field(name: 'username').set(LOGIN[:username])
    @browser.text_field(name: 'password').set(LOGIN[:password])
    @browser.button(class: 'icon-submit fa fa-angle-right').click
  end
end