require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/friendship'
require_relative 'models/member'
require_relative 'models/post'
require_relative 'controllers'
require 'sinatra/flash'
# require 'sinatra-redirect-with-flash'

if settings.test?
  puts "test!@"
  set :database, "sqlite3://db/members_test.db"
else
  puts "no test :("
  set :database, "sqlite3://db/members_development.db"
end
