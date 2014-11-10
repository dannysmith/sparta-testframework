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
    CourseCreationPage.new @browser
  end

  def course_mgmt
    CourseManagementPage.new @browser
  end

  def login_page
    LoginPage.new @browser
  end

  def course_details
    CourseDetailsPage.new @browser
  end

  def course_editing
    CourseEditingPage.new @browser
  end

  def enrolled_users
    EnrolledUsersPage.new @browser
  end
  
  def all_course_page
    CoursePage.new @browser
  end
  
  def all_course_page
    CoursePage.new @browser
  end

end
