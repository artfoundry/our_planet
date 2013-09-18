require 'sinatra'

enable :sessions

get '/' do
  erb :home
end

get '/login' do
  erb :login
end

helpers do 
  def title 
    "Our Planet"
  end
end
