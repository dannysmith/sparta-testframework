class App
  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end

  def dashboard
    Dashboard.new @browser
  end

  def registration
    RegistrationPage.new @browser
  end

  def calendar
    CalendarPage.new @browser
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

  def course_editing
    MoodleCourseEditingPage.new @browser
  end

  def enrolled_users
    MoodleEnrolledUsersPage.new @browser
  end

end
