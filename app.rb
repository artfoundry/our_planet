require 'sinatra'
require 'sinatra/activerecord'
require_relative 'models/member'

set :database, "sqlite3:///members.db"
