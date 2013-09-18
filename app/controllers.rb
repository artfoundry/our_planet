require 'sinatra'

enable :sessions

get '/' do
  session['username'] ||= nil
  erb :home
end

get '/login' do
  erb :login
end

get '/home' do
  erb :home
end

post '/login' do
  session['username'] = params[:username]
  redirect '/home'
end

helpers do 
  def title 
    "Our Planet"
  end
end
