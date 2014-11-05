
class HomePage < GenericPage

  def visit
    @browser.goto EnvConfig.base_url
  end

end
