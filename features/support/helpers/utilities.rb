# Provides useful helper methods
#-------------------------------------------------------------------------------------------------------------
# Author:      Danny Smith
# Modified:    2013-11-30
#-------------------------------------------------------------------------------------------------------------

def random_string(len)
  (0...len).map{ ('a'..'z').to_a[rand(26)] }.join
end

def random_email
  "#{random_string(8)}@#{random_string(10)}.com"
end

def clear_all_products
 Kernel.puts "Removing #{Product.all.count} products."
 Product.all.delete_if {|prod| prod.destroy!}
end

def clear_all_categories
 Kernel.puts "Removing #{Category.all.count} categories."
 Category.all.delete_if {|cat| cat.destroy!}
end

def clear_all_members
  Kernel.puts "Removing #{Member.all.count} members."
  Member.all.delete_if {|mem| mem.destroy!}
end
