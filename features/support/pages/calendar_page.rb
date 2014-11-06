require 'date'
require 'rspec'
class CalendarPage < GenericPage

  def visit
    @browser.goto "http://unix.spartaglobal.com/moodle3/calendar/view.php?view=month"
  end 
  
  def check_events
            
    past_events_list

    expect(@past_events.empty?).to be(false)
  end
  
  def choose_past_events
    past_events_list
    @browser.element(:text, @past_events.last).when_present.click
    expect(@browser.div(:class, "name").text).to include @past_events.last
  end

  def create_event
    yesterday_day = Date.today.prev_day.day
    yesterday_month = Date.today.prev_day.month
    @browser.goto "http://unix.spartaglobal.com/moodle3/calendar/event.php?action=new&course"
    @browser.text_field(:id, "id_name").set "Test Event"
    @browser.select_list(:id, "id_timestart_day").select_value(yesterday_day)
    @browser.select_list(:id, "id_timestart_month").select_value(yesterday_month)
    @browser.button(:id, "id_submitbutton").click
  end

  def update_event_title
    @browser.element(:title, "Edit event").click
    @browser.text_field(:id, "id_name").set "Updated event title"
  end

  def update_event_date
    tomorrow_day = (Date.today +1).day
    tomorrow_month = (Date.today +1).month
    @browser.element(:title, "Edit event").click
    @browser.select_list(:id, "id_timestart_day").select_value(tomorrow_day)
    @browser.select_list(:id, "id_timestart_month").select_value(tomorrow_month)
    @browser.button(:id, "id_submitbutton").click
  end
  
private
  def past_events_list
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
end

