# Used for visiting home page
#-------------------------------------------------------------------------------------------------------------
# Author:      
# Modified:    2014-12-11
#-------------------------------------------------------------------------------------------------------------
class HomePage < GenericPage

  def visit
    @browser.goto EnvConfig.base_url
  end

  def click_on_course course
    @browser.a(text: course).click
  end
end
