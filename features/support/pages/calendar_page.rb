require_relative 'home_page'
class CalendarPage < HomePage

  def visit_calendar
    @browser.element(:title, "Spartiaite LMS").click
  end 
end