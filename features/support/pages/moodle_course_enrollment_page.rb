class MoodleCourseEnrollmentPage < GenericPage
  def enrol
    @browser.button(value: 'Enrol me').when_present.click
  end
  
  def unenrol
    @browser.a(href: /\w*self\/unenrolself\w*/).when_present.click
    @browser.button(value: 'Continue').when_present.click
  end
end
