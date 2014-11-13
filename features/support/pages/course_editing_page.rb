# Used for editing course and changing it's short title
#-------------------------------------------------------------------------------------------------------------
# Author:      Romeo Ledesma
# Modified:    2014-12-11
#-------------------------------------------------------------------------------------------------------------
class CourseEditingPage < GenericPage
  def change_course_short_title_to new_short_title
    @browser.text_field(id: 'id_shortname').set new_short_title
    @browser.input(value: 'Save changes').click
  end
end
