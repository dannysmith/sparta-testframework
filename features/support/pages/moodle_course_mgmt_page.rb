class MoodleCourseManagementPage < GenericPage
  
  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle3/course/management.php"
  end
  
  def goto_course_creation_form
    @browser.a(text: 'Create new course').when_present.click
  end
  
  def expand_software_testing_category
    @browser.a(text: 'Software Testing').when_present.click
  end
  
  def goto_course course_name
    @browser.a(text: course_name).when_present.click
  end
  
  def course_management_page
    @browser.text.include?("Course and category management")
  end
end