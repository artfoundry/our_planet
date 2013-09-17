require 'rake'
require 'rspec/core/rake_task'
require_relative 'db/config'
require 'sqlite3'
require "./app"


desc "drop the database"
task "db:drop" do
  rm_f 'db/migrate/posts.sqlite3'
end
