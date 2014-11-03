class App

  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end
  
  def p_login
    Moodle_Login.new @browser
  end

end
