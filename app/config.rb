require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/friendship'
require_relative 'models/member'

set :database, "sqlite3:///db/members.db"
