class MoodleEnrolledUsersPage < GenericPage
  def enrol name
    
    @browser.input(value: 'Enrol users', index: 1).click
    
    @browser.text_field(id: 'enrolusersearch').when_present.set name
    
    @browser.input(id: 'searchbtn').click
    
    results_list = @browser.div(class: 'users').when_present.divs(class: /user clearfix\w*/)
    
    results_list.each do |result|
      if result.div(class: 'details').div(class: 'fullname').text.include? name
        result.div(class: 'options').input(value: 'Enrol').click
      end
    end
    
    @browser.input(value: 'Finish enrolling users').click
    
    enrolled_users_list = @browser.table(class: 'userenrolment table table-responsive ajaxactive').when_present.tbody.trs(class: /userinforow\w*/)
    
    enrolled_users_list.each do |enrolled_user|
      if enrolled_user.td(class: 'field col_userdetails cell c0').div(class: /\w*_firstname/).text.include? name
        enrolled_user.td(class: 'field col_role cell c2').div.a.when_present.click
        
        @browser.input(value: 'Teacher').when_present.click
        
        expect(enrolled_user.td(class: /\w*c2/).div(class: 'roles').div(class: /\w*role_3/).when_present.text).to include('Teacher') 
      end
    end
  end
end