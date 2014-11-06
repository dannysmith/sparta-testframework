<<<<<<< HEAD
require_relative 'generic'
=======
>>>>>>> origin/Login

class HomePage < GenericPage

  def visit
    @browser.goto EnvConfig.base_url
  end

end
