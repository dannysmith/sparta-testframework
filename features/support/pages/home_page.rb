
class HomePage < GenericPage

  def visit
    @browser.goto EnvConfig.base_url
  end

  def visit_login
    @browser.a(:title, "Log in").click
  end

end
