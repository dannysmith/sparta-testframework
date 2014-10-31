class App

  def initialize(b)
    @browser = b
  end

  def home
    HomePage.new @browser
  end

end
