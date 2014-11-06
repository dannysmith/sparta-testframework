class App

  def initialize(b)
    @browser = b
  end

  def home
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
  
  def course_details
    MoodleCourseDetailsPage.new @browser
  end

end
