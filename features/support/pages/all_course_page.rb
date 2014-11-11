class CoursePage < GenericPage

  def visit
    @browser.goto "#{EnvConfig.base_url}/course/"
  end
end