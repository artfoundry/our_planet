require 'sinatra'
require './app'

enable :sessions

get '/' do
  session['username'] ||= nil
  erb :home
end

get '/member/new' do
  erb :signup
end

post '/member/create' do
  member = Member.new(params)
  session['username'] = "#{member.first_name} #{member.last_name}"
  redirect '/member/new' unless member.errors.empty?
  redirect '/home'
end

get '/login' do
  erb :login
end

get '/home' do
  erb :home
end

post '/login' do
  session['username'] = params[:email]
  redirect '/home'
end

helpers do 
  def title 
    "Our Planet"
  end
end
