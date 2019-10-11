require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra/reloader'
require './app.rb'

Dir[File.dirname(__FILE__) + '/models/*.rb'].each { |f| require f }
Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each { |f| require f }

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)
Time.zone = 'Tokyo'
ActiveRecord::Base.default_timezone = :local

run Sinatra::Application
