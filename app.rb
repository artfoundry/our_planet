require 'sinatra'
require 'sinatra/activerecord'
require_relative 'app/models/friendship'
require_relative 'app/models/member'

set :database, "sqlite3:///db/members.db"
