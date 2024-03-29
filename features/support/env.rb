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
POSTS = YAML.load_file('features/support/data/default_product_data.yml')
EMAIL_WAIT = 120

WEEKLY_POST = {
               full_title: POSTS[:weekly][0][:full_title],
               short_title: POSTS[:weekly][0][:short_title],
               type: POSTS[:weekly][0][:type]
              }

TOPICS_POST = {
               full_title: POSTS[:topics][0][:full_title],
               short_title: POSTS[:topics][0][:short_title],
               type: POSTS[:topics][0][:type]
              }

INVISI_POST = {
               full_title: POSTS[:invisible][0][:full_title],
               short_title: POSTS[:invisible][0][:short_title],
               type: POSTS[:invisible][0][:type]
              }

# Add the license hack to the database (see IRD-1236). Can be removed when we have a proper licence.
#require 'mysql2'
#require 'sequel'
#DB = Sequel.connect(adapter: 'mysql2',
#                    user: EnvConfig.database_username,
#                    host: EnvConfig.database_url,
#                    database: EnvConfig.database_name,
#                    password: EnvConfig.database_password)
#
## Set up World
#World(RSpec::Matchers)



