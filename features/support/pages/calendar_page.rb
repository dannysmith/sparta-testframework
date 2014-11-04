require_relative 'home_page'
class CalendarPage < HomePage

  def visit_calendar
    @browser.element(:title, "Spartiaite LMS").click
    @browser.a(:href, "http://unix.spartaglobal.com/moodle3/calendar/view.php?view=month")
  end 

  def create_event
    @browser.element(:text, "New Event")
    @browser.text_field(:id, "id_name").set "Test Event"
    @browser.text_field(:id, "id_descriptionedittable").set "Test event description"
    
  end
end