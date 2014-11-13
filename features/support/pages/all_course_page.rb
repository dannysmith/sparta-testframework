# Used for accessing list of all courses
#-------------------------------------------------------------------------------------------------------------
# Author:      Dave Kent
# Modified:    2014-12-11
#-------------------------------------------------------------------------------------------------------------
class CoursePage < GenericPage

  def visit
    @browser.goto "#{EnvConfig.base_url}/course/"
  end
end