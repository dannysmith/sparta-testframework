require 'fileutils'
require 'rspec'
require 'rspec/expectations'
require 'watir'
require 'watir-webdriver'
require 'yaml'

# Test development and debugging gems
require 'pry'
require 'rubocop'

require 'yaml'

# Load the generic libraries in lib..
Dir[File.dirname(__FILE__) + '/../../lib/*.rb'].each { |f| require f }

require File.dirname(__FILE__) + '/pages/generic.rb'
Dir[File.dirname(__FILE__) + '/pages/*.rb'].each { |f| require f }

# Set up World
World(RSpec::Matchers)

CREDENTIALS = YAML.load_file('features/support/data/users.yml')
POST_TITLE = YAML.load_file('features/support/data/default_product_data.yml')

# Add the license hack to the database (see IRD-1236). Can be removed when we have a proper licence.
#require 'mysql2'
#require 'sequel'
#DB = Sequel.connect(adapter: 'mysql2',
#                    user: EnvConfig.database_username,
#                    host: EnvConfig.database_url,
#                    database: EnvConfig.database_name,
#                    password: EnvConfig.database_password)
                    
# Scripts for the sql database. One to check the database can be connected to and one to delete the user derek. 
# DO NOT USE AT THE MOMENT. THESE HAVENT BEEN TESTED YET!
                    
#DB.fetch("SELECT * FROM mdl3_user WHERE userame = 'derek'") do |row|
#  p row[:username]
#end

#mdl3_user.where('username < ?', 'derek').delete

# Set up World
World(RSpec::Matchers)



