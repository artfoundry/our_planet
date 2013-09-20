require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/friendship'
require_relative 'models/member'
require_relative 'models/post'
require_relative 'controllers'

if settings.test?
  set :database, "sqlite3:///db/members_test.db"
else
  configure :development do
    set :database, "sqlite3:///mydb.sqlite3"
  end

  configure :production do
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
  end
end
