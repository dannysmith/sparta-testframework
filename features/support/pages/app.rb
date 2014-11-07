class App

   # TODO: Remove any superfluous methods here. All mergeed since I don;t know what's being used.

  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end

  # def login
  #   MoodleLoginPage.new @browser
  # end

  def dashboard
    Dashboard.new @browser
  end

  def test_page
    TestPage.new @browser
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
