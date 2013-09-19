require './app/config'
require 'sinatra/activerecord/rake'

desc "Drop the database"
  task 'db:drop' do
    rm_f 'db/members.db'
    puts "dropped it like its hot!!!"
end
