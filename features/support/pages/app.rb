class App

  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end


  def test_page
    TestPage.new @browser
  end


  def calendar
    CalendarPage.new @browser
  end

end
