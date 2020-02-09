require 'rubygems'
require 'bundler/setup'
Bundler.require

require 'active_record'
require 'pg'
require './model_factory'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'postgresql' or 'sqlite3' or 'oracle_enhanced'
  host:     'localhost',
  database: 'csv_processor',
  username: 'postgres',
  password: ''
)

# class CsvToTable
#   def initialize(args)
    
#   end
  
#   def create_table
#     ModelFactory.build_model({schema: 'public', table: 'my_table_2'})
#   end

#   def table_name
#   end

#   def columns
#   end
# end

model = ModelFactory.build_model({schema: 'public', table: 'my_table_2'})
model.new(name: 'Mario', address: '742 Evergreen Terrace').save!