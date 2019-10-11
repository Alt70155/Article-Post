require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)
Time.zone = 'Tokyo'
ActiveRecord::Base.default_timezone = :local
