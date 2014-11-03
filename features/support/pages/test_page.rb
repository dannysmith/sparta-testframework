class TestPage < GenericPage
  def visit
    @browser.goto "http://google.com"
  end
end
