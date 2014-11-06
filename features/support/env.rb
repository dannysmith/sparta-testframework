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
<<<<<<< HEAD
require File.dirname(__FILE__) + '/pages/generic.rb'
Dir[File.dirname(__FILE__) + '/pages/*.rb'].each { |f| require f }

# Set up World
World(RSpec::Matchers)
=======
CREDENTIALS = YAML.load_file('features/support/data/users.yml')

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
>>>>>>> origin/Login


