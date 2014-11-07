require_relative 'generic'

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
  
  def click_on option
    options = {
               view:           0,
               edit:           1,
               enrolled_users: 2,
               delete:         3,
               hide:           4,
               backup:         5,
               restore:        6
              }
    
    #@browser.a(text: 'Edit').when_present.click - this doesn't work so I was forced to do the following..
  
    @browser.div(class: 'listing-actions course-detail-listing-actions').wait_until_present
    # course_options_list = @browser.div(class: 'listing-actions course-detail-listing-actions').wait_until_present
    # doesn't work either

    # so what i did was took the div wrapper for all the available options for a course..
    course_options_list = @browser.div(class: 'listing-actions course-detail-listing-actions')
    # took all the available options for a course..
    course_options = course_options_list.as
    # identified that option..
    course_option = course_options[options[option]]
    # then clicked it
    course_option.click
  end
end