require_relative 'home_page'
require 'date'
require 'rspec'
class CalendarPage < HomePage

  def visit_calendar
     @browser.goto "http://unix.spartaglobal.com/moodle3/calendar/view.php?view=month"
  end 
  
  def populate_events
    today = Date.today.day
    calendar = @browser.table(:class, "calendarmonth calendartable")
    rows = calendar.trs
    @past_events = []
    rows.each_with_index do |row,i|
      next if i == 0
      
      cell = row.tds
      
      cell.each do |data|
        @past_events.push(data.ul.li.a.text) if data.text.to_i < today && data.text.to_i != 0 && data.ul.exists?
      end
    end
  end
  
  def check_events
            
    populate_events

    expect(@past_events.empty?).to be(false)
  end
  
  def choose_past_events
    populate_events
    
    @browser.element(:text, @past_events.last).click
    expect(@browser.text).to include "Day view"
  end

  def create_event
    @browser.element(:text, "New Event")
    @browser.text_field(:id, "id_name").set "Test Event"
    @browser.text_field(:id, "id_descriptionedittable").set "Test event description"
    
  end
end