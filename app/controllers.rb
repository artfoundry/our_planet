require 'sinatra'
require_relative './config'

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

get '/user/:id/othermembers' do #show all unfriended friends
  @members = Member.all
  erb :requests
end

post '/user/:id/othermembers' do
  Friendship.create(member_id: params[:id], friend_id: params[:friend_id], accepted?: false)
  redirect "/user/#{params[:id]}/othermembers"
end

get '/user/:id/friends' do #show confirmed and pending friends
  @members = Member.all
  erb :friends
end

post '/user/:id/friends' do 
  # friendship = Friendship.where(:member_id => params[:id], :friend_id => params[:friend_id]).take
  # unless friendship != nil
    friendship = Friendship.where(:member_id => params[:friend_id], :friend_id => params[:id]).take
  # end
  friendship.update_attributes(:accepted? => "true")
  friendship.save
  redirect "/user/#{params[:id]}/friends"
end

helpers do 
  def title 
    "Our Planet"
  end
end
