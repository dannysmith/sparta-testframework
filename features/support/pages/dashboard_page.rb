class Dashboard < GenericPage
  def site_admin
    @browser.text.include?("Site Admin")
  end
  
  def admin_panel
    @browser.p(:id, "expandable_branch_71_siteadministration").text
  end
  
  def guest
    @browser.a(:title, "Guest user  ").text
  end
  
  def user
    @browser.a(:title, "Aaron Muir").text
  end
  
  def admin
    @browser.a(:title, "Admin User").text
  end
end
