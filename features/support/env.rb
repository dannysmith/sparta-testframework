require 'fileutils'
require 'rspec'
require 'rspec/expectations'
require 'watir'
require 'watir-webdriver'

# Test development and debugging gems
require 'pry'
require 'rubocop'


# Load the generic libraries in lib..
Dir[File.dirname(__FILE__) + '/../../lib/*.rb'].each { |f| require f }

require File.dirname(__FILE__) + '/pages/generic.rb'
Dir[File.dirname(__FILE__) + '/pages/*.rb'].each { |f| require f }

# require 'mysql2'
# require 'sequel'
# DB = Sequel.connect(adapter: 'mysql2',
#                     user: EnvConfig.database_username,
#                     host: EnvConfig.database_url,
#                     database: EnvConfig.database_name,
#                     password: EnvConfig.database_password)
# Add the license hack to the database (see IRD-1236). Can be removed when we have a proper licence.
#require 'mysql2'
#require 'sequel'
#DB = Sequel.connect(adapter: 'mysql2',
#                    user: EnvConfig.database_username,
#                    host: EnvConfig.database_url,
#                    database: EnvConfig.database_name,
#                    password: EnvConfig.database_password)

# Set up World
World(RSpec::Matchers)

