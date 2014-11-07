Given /^that I am logged in as a Teacher$/ do
  @app.login_page.login_as :admin
end

When /^I select the Software Testing category in the Course Management Page$/ do
  @app.course_mgmt.visit
  @app.course_mgmt.expand_software_testing_category
end

And /^I choose to create a new course$/ do
  @app.course_mgmt.goto_course_creation_form
end

Then /^I should be sent to the Edit Course Settings page$/ do
  expect(@app.course_creation.title).to include('Add a new course')
end

And /^I enter the Full Title for the Course$/ do
  
  if @visibility == :invisible
    @app.course_creation.set_title :full, POST_TITLE[:invisible][0][:full_title]
  else
    if @course_format == :topics
      @app.course_creation.set_title :full, POST_TITLE[:topics][0][:full_title]
    else
      @app.course_creation.set_title :full, POST_TITLE[:weekly][0][:full_title]
    end
  end
end

And /^I enter the Short Title for the Course$/ do
  
  if @visibility == :invisible
    @app.course_creation.set_title :short, POST_TITLE[:invisible][0][:short_title]
  else
    if @course_format == :topics
      @app.course_creation.set_title :short, POST_TITLE[:topics][0][:short_title]
    else
      @app.course_creation.set_title :short, POST_TITLE[:weekly][0][:short_title]
    end
  end
end
  
When /^I set Topics as the Course Format$/ do
  @app.course_creation.set_course_format_to 'topics'
  @course_format = :topics
end

When /^I set Weekly as the Course Format$/ do
  @app.course_creation.set_course_format_to 'weeks'
  @course_format = :weekly
end
    
Then /^the new course should be created$/ do
  @app.course_creation.create_course
end
    
And /^it should appear in the course list bearing its intended details$/ do
  @app.course_mgmt.visit
  
  @app.course_mgmt.expand_software_testing_category

  if @visibility == :invisible
    @app.course_mgmt.goto_course POST_TITLE[:invisible][0][:full_title]
    
    expect(@browser.div(class: /\w*fullname/).when_present.text).to include(POST_TITLE[:invisible][0][:full_title])
    expect(@browser.div(class: /\w*shortname/).when_present.text).to include(POST_TITLE[:invisible][0][:short_title])
    
  else
    if @course_format == :topics
      @app.course_mgmt.goto_course POST_TITLE[:topics][0][:full_title]

      expect(@browser.div(class: /\w*fullname/).when_present.text).to include(POST_TITLE[:topics][0][:full_title])
      expect(@browser.div(class: /\w*shortname/).when_present.text).to include(POST_TITLE[:topics][0][:short_title])

      expect(@browser.div(class: /\w*format/).when_present.text).to include('Topics format')
    else
      @app.course_mgmt.goto_course POST_TITLE[:weekly][0][:full_title]

      expect(@browser.div(class: /\w*fullname/).when_present.text).to include(POST_TITLE[:weekly][0][:full_title])
      expect(@browser.div(class: /\w*shortname/).when_present.text).to include(POST_TITLE[:weekly][0][:short_title])

      expect(@browser.div(class: /\w*format/).when_present.text).to include('Weekly format')
    end
  end
end

When /^I set the Course to be Invisible$/ do
  @app.course_creation.set_visibility_to '0'
  @visibility = :invisible
end

And /^only an Administrator or a Teacher can view it$/ do
  @app.home.visit
  
  expect(@browser.a(text: POST_TITLE[:invisible][0][:full_title]).exists?).to be true
  
  @app.home.logout
  
  @app.login_page.login_as :student

  # don't expect the student to see the invisible course
  expect(@browser.a(text: POST_TITLE[:invisible][0][:full_title]).exists?).to be false
end
