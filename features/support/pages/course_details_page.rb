# Used for checking course title and deleting course
#-------------------------------------------------------------------------------------------------------------
# Author:      Romeo Ledesma
# Modified:    2014-12-11
#-------------------------------------------------------------------------------------------------------------
class CourseDetailsPage < GenericPage

  def course_title
    @browser.h3(:id, "course-detail-title").text
  end
  
  def delete_course
    @browser.a(:text, "Delete").when_present.click
    @browser.div(:class, "singlebutton").when_present.click
    @browser.div(:id, "yui_3_15_0_3_1415273565381_278").button.click
  end
  
end
