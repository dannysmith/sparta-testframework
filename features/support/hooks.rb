# Use the headless gem if we've set the HEADLESS var to true
if ENV['HEADLESS']
  require 'headless'
  headless = Headless.new :display => '100'
  headless.start
end

# Set up browser
browser = Watir::Browser.new (ENV['BROWSER'] || 'firefox').to_sym
$setup_done = false

Before do
  @browser = browser
  @browser.window.resize_to(1000, 900)
  @browser.cookies.clear

  @app = App.new @browser



  unless $setup_done
    $setup_done = true
    # This stuff will only run before the first scenario executed. Use it to set up data etc.
  end

end

After do |scenario|

  @browser.driver.manage.delete_all_cookies

  # Output a screenshot (and video if HEADLESS) if the scenario failed
  if scenario.failed?
    output_path = File.expand_path(File.dirname(__FILE__) + '/../../results/screenshots/')
    scenario_name =  "#{Time.now.strftime("%Y%m%d-%H_%M_%S")}-#{scenario.to_sexp[3].gsub(/[^\w\-]/, '-')}"
    output_path += '/' + scenario_name
    browser.screenshot.save "#{output_path}.png"

    image = browser.screenshot.base64
    embed "data:image/png;base64,#{image}",'image/png'

  end
end

Before('@MDL-21') do
  @app.login_page.login_as :admin
  
  @browser.goto 'http://unix.spartaglobal.com/moodle3/admin/user.php'
  
  @browser.text_field(id: 'id_realname').set('derek')
  
  @browser.button(name: 'addfilter').click
  
  user_accounts = @browser.table(id: 'users').when_present.tbody.trs
  
  user_accounts.each do |acct|
    if acct.td(class: /\w*c0\w*/).a.text == 'Derek Derekson'
      acct.td(class: /\w*c5\w*/).a(title: 'Delete').click
      
      @browser.button(value: 'Continue').when_present.click
    end
  end
  
  @app.login_page.logout
end

After('@MDL-47') do
  # Delete Aaron Muir from the course's Teachers list
  # so he can be added as a teacher again the next time 
  # this scenario is run
  
  @app.login_page.logout
  
  @app.login_page.login_as :admin
  
  @browser.goto 'http://unix.spartaglobal.com/moodle3/enrol/users.php?id=77&page=0&perpage=100&sort=lastname&dir=ASC'
  
  enrolled_users = @browser.table(class: 'userenrolment table table-responsive ajaxactive').tbody.trs
  
  enrolled_users.each do |enrolled_user|
    if enrolled_user.td.div(class: /\w*firstname/).text == 'Aaron Muir'
      enrolled_user.td(class: /\w*c4\w*/).div.a(title: 'Unenrol').click
      
      @browser.button(value: 'Continue').click
    end
  end
end

After('@MDL-14') do
  @app.home.visit
  
  @browser.a(text: 'Anquite Course 2').when_present.click
  
  @app.course_enrollment.unenrol
end

# After all features have executed
at_exit do

  browser.close

  if ENV['HEADLESS']
    headless.destroy
  end
end

def email_deletion
  @app.registration.login_email
  @app.registration.email_load_timex
  @browser.div(:class, "T-Jo-auh").click
  @browser.div(:class, "ar9 T-I-J3 J-J5-Ji").click
end


