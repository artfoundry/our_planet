require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/friendship'
require_relative 'models/member'
require_relative 'models/post'
require_relative 'controllers'

if settings.test?
  set :database, "sqlite3:///db/members_test.db"
else
  set :database, "sqlite3:///db/members_development.db"
end
