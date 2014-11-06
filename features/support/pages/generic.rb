class GenericPage
  include RSpec::Matchers
  attr_accessor :browser

  def initialize(browser)
    @browser = browser
  end

  # Expects a watir hash like {:id => "abc"}
  def element_exists?(el)
    @browser.element(el).exists?
  end

  def title
    @browser.title
  end

  def url
    @browser.url
  end
<<<<<<< HEAD
    
  def goto_course_management
    @browser.span(text: 'Site administration').when_present.click
    @browser.span(text: 'Courses').when_present.click
    @browser.a(text: 'Manage courses and categories').when_present.click
  end
  
  def logout
    @browser.goto "http://unix.spartaglobal.com/moodle3/login/logout.php"
    @browser.input(value: 'Continue').click
  end
=======
  

>>>>>>> origin/Login
end
