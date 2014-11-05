require_relative 'generic'

class MoodleCourseManagementPage < GenericPage
  
  def goto_course_creation_form
    @browser.a(text: 'Create new course').when_present.click
  end
  
  def expand_software_testing_category
    @browser.a(text: 'Software Testing').when_present.click
  end
  
  def goto_course course_name
    @browser.a(text: course_name).when_present.click
  end
end