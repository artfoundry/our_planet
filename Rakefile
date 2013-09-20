require './app/config'
require 'sinatra/activerecord/rake'

desc "Drop it like it's hot"
  task 'db:drop' do
    rm_f 'db/members_development.db'
    puts "dropped it like its hot!!!"
end
