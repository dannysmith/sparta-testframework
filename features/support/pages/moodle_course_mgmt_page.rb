class MoodleCourseManagementPage < GenericPage
  
  def visit
    @browser.goto "#{EnvConfig.base_url}/course/management.php"
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
               view:           /\w*course\/view.php\w*/,
               edit:           /\w*course\/edit.php\w*/,
               enrolled_users: /\w*enrol\/users.php\w*/,
               delete:         /\w*course\/delete.php\w*/,
               hide:           /\w*course\/manangemet.php\w*/,
               backup:         /\w*backup\/backup.php\w*/,
               restore:        /\w*backup\/restorefile.php\w*/
              }
    
    @browser.div(class: 'course-detail').div.a(href: options[option]).when_present.click
  end
end
