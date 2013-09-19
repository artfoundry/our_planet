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

describe 'login process' do

  xit "should save the username to a cookie on login" do
    post '/login', params={username:"James Bond"}
    puts last_request.env.inspect
    session['username'] == params[:username]
  end
end
