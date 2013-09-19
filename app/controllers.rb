require 'sinatra'
require_relative './config'

enable :sessions

get '/' do
  session['member'] ||= nil
  erb :home
end

get '/member/new' do
  erb :signup
end

post '/member/create' do
  member = Member.new(params)
  set_member_session(member)
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
  current_member = Member.find(email: params[:email])
  set_member_session(current_member) if current_member
  redirect '/home'
end

get '/:id' do
  @members = Member.all
  erb :requests
end

helpers do 
  def title 
    "Our Planet"
  end

  def set_member_session(member)
    session['member'] = member 
  end
end
