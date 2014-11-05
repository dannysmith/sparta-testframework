Given /^that I am logged in as a Teacher$/ do
  @homepage = MoodleHomePage.new(@browser)
  @homepage.visit
  
  @login_page = MoodleLoginPage.new(@browser)
  @login_page.login 'admin'
end

And /^I am in the Course and category management page$/ do
  @login_page.goto_course_management
  @course_mgmt = MoodleCourseManagementPage.new(@browser)
end

Given /^I select the Software Testing category$/ do
  @course_mgmt.expand_software_testing_category
end

When /^I choose to create a new course$/ do
  @course_mgmt.goto_course_creation_form
end

Then /^I should be sent to the Edit Course Settings page$/ do
  @course_creation = MoodleCourseCreationPage.new(@browser)
  expect(@course_creation.title).to include('Add a new course')
end

And /^I enter the Full Title for the Course$/ do
  
  if @visibility == 'invisible'
    @course_creation.set_title 'full_title', 'INVISIBLE FULL TITLE TEST'
  else
    if @course_format == 'topics'
      @course_creation.set_title 'full_title', 'TOPICS FULL TITLE TEST'
    else
      @course_creation.set_title 'full_title', 'WEEKLY FULL TITLE TEST'
    end
  end
end

And /^I enter the Short Title for the Course$/ do
  
  if @visibility == 'invisible'
    @course_creation.set_title 'short_title', 'INVISIBLE SHORT TITLE TEST'
  else
    if @course_format == 'topics'
      @course_creation.set_title 'short_title', 'TOPICS SHORT TITLE TEST'
    else
      @course_creation.set_title 'short_title', 'WEEKLY SHORT TITLE TEST'
    end
  end
end
  
When /^I set Topics as the Course Format$/ do
  @course_creation.set_course_format_to 'topics'
  @course_format = 'topics'
end

When /^I set Weekly as the Course Format$/ do
  @course_creation.set_course_format_to 'weeks'
  @course_format = 'weekly'
end
    
Then /^the new course should be created$/ do
  @course_creation.create_course
end
    
And /^it should appear in the course list bearing its intended details$/ do
  @homepage.visit
  @homepage.goto_course_management
  
  @course_mgmt.expand_software_testing_category

  if @visibility == 'invisible'
    @course_mgmt.goto_course 'INVISIBLE FULL TITLE TEST'
    
    expect(@browser.div(class: /\w*fullname/).when_present.text).to include('INVISIBLE FULL TITLE TEST')
    expect(@browser.div(class: /\w*shortname/).when_present.text).to include('INVISIBLE SHORT TITLE TEST')
    
  else
    if @course_format == 'topics'
      @course_mgmt.goto_course 'TOPICS FULL TITLE TEST'

      expect(@browser.div(class: /\w*fullname/).when_present.text).to include('TOPICS FULL TITLE TEST')
      expect(@browser.div(class: /\w*shortname/).when_present.text).to include('TOPICS SHORT TITLE TEST')

      expect(@browser.div(class: /\w*format/).when_present.text).to include('Topics format')
    else
      @course_mgmt.goto_course 'WEEKLY FULL TITLE TEST'

      expect(@browser.div(class: /\w*fullname/).when_present.text).to include('WEEKLY FULL TITLE TEST')
      expect(@browser.div(class: /\w*shortname/).when_present.text).to include('WEEKLY SHORT TITLE TEST')

      expect(@browser.div(class: /\w*format/).when_present.text).to include('Weekly format')
    end
  end
end

When /^I set the Course to be Invisible$/ do
  @course_creation.set_visibility_to '0'
  @visibility = 'invisible'
end

And /^only an Administrator or a Teacher can view it$/ do
  @course_mgmt.visit
  @homepage.visit
  
  expect(@browser.a(text: 'INVISIBLE FULL TITLE TEST').exists?).to be true
  
  puts "done admin"
  @course_mgmt.logout
  @login_page.login 'student'
  
  expect(@browser.a(text: 'INVISIBLE FULL TITLE TEST').exists?).to be false
end