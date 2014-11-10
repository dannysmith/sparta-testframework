require 'date'
require 'rspec'

class CalendarPage < GenericPage

  def visit
    @browser.goto "#{EnvConfig.base_url}/calendar/view.php?view=month"
  end 
  
  def check_events
    past_events_list_current
    expect(@past_events_current.empty?).to be(false)
  end
  
  def choose_past_events
    past_events_list_current
    @browser.element(:text, @past_events_current.last).click
    expect(@browser.div(:class, "name").text).to include @past_events_current.last
    visit
  end

  def create_event
    yesterday_day = Date.today.prev_day.day
    yesterday_month = Date.today.prev_day.month
    @browser.goto "#{EnvConfig.base_url}/calendar/event.php?action=new&course"
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
  
  def delete_event
    past_events_list_current
    past_events_list_current_length
    @browser.element(:text, @past_events_current.last).click
    @browser.element(:title, "Delete event").click
    @browser.button(:type, "submit").click
    visit
    past_events_list_deleted
    past_events_list_deleted_length
    expect(@events_list_current_length > @events_list_deleted_length).to be(true)
  end
  
  def past_events_list_current_length
    @events_list_current_length = @past_events_current.length
  end
  
  def past_events_list_deleted_length
    @events_list_deleted_length = @past_events_deleted.length  
  end
   
private
 # These two are being duplicated purely because the variables were overwriting each others. 
 # If you can figure out a more 'eloquent' way please do!
  def past_events_list_current
    yesterday = Date.today.prev_day.day
    calendar = @browser.table(:class, "calendarmonth calendartable")
    @past_events_current = []
    
    rows = calendar.trs
    rows.each_with_index do |row,i|
      next if i == 0
       
       cells = row.tds
       
       cells.each do |cell|
         if cell.text.to_i <= yesterday && cell.text.to_i != 0 && cell.li.exists?
           cell_events = cell.lis
           
           cell_events.each do |event|
             @past_events_current.push(event.text)
           end
         end
       end
     end
   end
   
   def past_events_list_deleted
    yesterday = Date.today.prev_day.day
    calendar = @browser.table(:class, "calendarmonth calendartable")
    @past_events_deleted = []
    rows = calendar.trs
    rows.each_with_index do |row,i|
      next if i == 0
       
       cells = row.tds
       
       cells.each do |cell|
         if cell.text.to_i <= yesterday && cell.text.to_i != 0 && cell.li.exists?
           cell_events = cell.lis
           
           cell_events.each do |event|
             @past_events_deleted.push(event.text)
           end
         end
       end
    end
   end
end

