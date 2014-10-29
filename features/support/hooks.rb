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

  unless $setup_done
    $setup_done = true
    # This stuff will only run before the first scenario executed. Use it to set up data etc.
  end

  headless.video.start_capture if ENV['HEADLESS']
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

    if ENV['HEADLESS']
      headless.video.stop_and_save("#{output_path}.mov")
      puts "See Video: #{output_path}.mov"
    end
  else
    headless.video.stop_and_discard if ENV['HEADLESS']
  end
end

# After all features have executed
at_exit do

  browser.close

  if ENV['HEADLESS']
    headless.destroy
  end
end




