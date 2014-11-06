require_relative 'generic'

class MoodleCourseCreationPage < GenericPage

  def set_title title_type, title
    if title_type == :full
      @browser.text_field(id: 'id_fullname').set(title)
    elsif title_type == :short
      @browser.text_field(id: 'id_shortname').set(title)
    else
      raise "Title type can only either be 'full_title' or 'short_title'."
    end
  end
  
  def set_visibility_to visibility
    @browser.select_list(id: 'id_visible').select_value(visibility)
  end
  
  def set_course_format_to course_format
    @browser.a(text: 'Course format').click
    @browser.select_list(id: 'id_format').when_present.select_value(course_format)
  end
  
  def create_course
    @browser.input(id: 'id_submitbutton').click
  end
end
