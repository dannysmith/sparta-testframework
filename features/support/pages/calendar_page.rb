require_relative 'home_page'
class CalendarPage < HomePage

  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle3/calendar/view.php?view=month"
  end 

  def create_event
    @browser.goto "http://unix.spartaglobal.com/moodle3/calendar/event.php?action=new&course"
    @browser.text_field(:id, "id_name").set "Test Event"
    @browser.select_list(:id, "id_timestart_day").select_value(10)
    @browser.select_list(:id, "id_timestart_month").select_value(11)
    @browser.button(:id, "id_submitbutton").click
  end
end