class App

  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end
  
  def login
    Moodle_Login.new @browser
  end

end
