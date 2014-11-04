
class HomePage < GenericPage

  def visit
    @browser.goto EnvConfig.base_url
    @browser.maximize
  end

  def visit_login
    @browser.a(:title, "Log in").click
  end
  
  def logout
    @browser.i(:class, "fa fa-user").click
    @browser.a(:title, "Log out").click
  end
end
