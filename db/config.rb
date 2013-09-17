# require 'active_record'
require "sinatra/activerecord/rake"


ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => "#{File.dirname(__FILE__)}/../db/migrate/posts.sqlite3")
