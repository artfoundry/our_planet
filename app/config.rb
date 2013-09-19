require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/friendship'
require_relative 'models/member'
require_relative 'models/post'

set :database, "sqlite3:///db/members.db"
