class GenericPage
  include RSpec::Matchers
  attr_accessor :browser

  def initialize(browser)
    @browser = browser
  end

  # Expects a watir hash like {:id => "abc"}
  def element_exists?(el)
    @browser.element(el).exists?
  end

  def title
    @browser.title
  end

  def url
    @browser.url
  end
  
  def logout
    @browser.goto "#{EnvConfig.base_url}/login/logout.php"
    @browser.input(value: 'Continue').click
  end
end
