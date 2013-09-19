require 'sinatra'
require_relative './config'

enable :sessions

get '/' do
  erb :home
end

get '/member/new' do
  erb :signup
end

post '/member/create' do
  member = Member.create(params)
  if member
    set_member_session(member.id)
    redirect '/home'
  else
    redirect '/member/new'
  end
end

get '/home' do
  erb :home
end

get '/login' do
  erb :login
end

post '/login' do
  member = Member.find_by email: params[:email]
  set_member_session(member.id) if member
  redirect '/home'
end

get '/logout' do
  erb :logout
end

post '/logout' do
  set_member_session(nil)
  redirect '/login'
end

get '/posts' do
  @posts = current_member.posts
  erb :posts
end

post "/posts" do
  current_member.posts.create(params[:post])
  redirect '/posts'
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

  def set_member_session(member_id)
    session['member_id'] = member_id 
  end

  def current_member
    if session['member_id']
      @member ||= Member.find(session['member_id'])
    end
    # returns nil if session is empty
  end
end
