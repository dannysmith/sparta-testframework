class App

  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end
  
  def login
    MoodleLogin.new @browser
  end
  
  def dashboard
    Dashboard.new @browser
  end

end
