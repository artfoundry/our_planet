require_relative 'app/models/friendship'
require_relative 'app/models/member'
require 'sinatra/activerecord'
require 'sinatra'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

set :database, "sqlite3:///db/members.db"
