require_relative 'generic'

class MoodleHomePage < GenericPage
  
  def visit
    @browser.goto EnvConfig.base_url
  end
end