class CoursePage < GenericPage

  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle3/course/"
  end
end