class App

  def initialize(b)
    @browser = b
  end

  def homepage
    HomePage.new @browser
  end

  def course_creation
    MoodleCourseCreationPage.new @browser
  end
  
  def course_mgmt
    MoodleCourseManagementPage.new @browser
  end
  
  def login_page
    MoodleLoginPage.new @browser
  end
end
