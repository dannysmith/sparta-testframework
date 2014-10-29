# Provides access to the iRedeem Categories
#-------------------------------------------------------------------------------------------------------------
# Author:      Danny Smith (danny@dasmith.co.uk)
# Modified:    2014-01-15
#
# Usage:
#
# @c = Category.new(browser, params)
#           Creates a new Category where `browser` is the browser object,
#
#
# Category.all                   Returns an array of all the Category objects.
# Category.first                 Returns the first Category created
# Category.last                  Returns the last Category created
#
#-------------------------------------------------------------------------------------------------------------

require 'betterlorem'

class Category
  attr_accessor :category_id, :data

  @@categories = []

  def initialize(browser, params = {})

    @browser = browser

    # Add to class variable
    @@categories << self

    return self
  end


  # Class methods

  def self.all
    return @@categories
  end

  def self.last
    return @@categories.last
  end

  def self.first
    return @@categories.first
  end
end
