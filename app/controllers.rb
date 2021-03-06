require 'sinatra'
require_relative './config'

enable :sessions

get '/' do
  redirect '/login' unless current_member
  @name = current_member.full_name
  @id = current_member.id
  @posts = current_member.posts
  erb :home
end

get '/member/new' do
  erb :signup
end

post '/member/create' do
  member = Member.create(params)
  if member
    set_member_session(member.id)
    redirect '/'
  else
    redirect '/member/new'
  end
end

get '/login' do
  erb :login
end

post '/login' do
  member = Member.find_by email: params[:email]
  if member && member.password == params[:password]
    set_member_session(member.id) 
    redirect '/'
  else
    flash[:error] = 'invalid login'
  end
  redirect '/login'  
end

get '/logout' do
  erb :logout
end

post '/logout' do
  set_member_session(nil)
  redirect '/login'
end

post '/posts' do
  member = Member.find(params[:current_wall].to_i)
  member.posts.create(params[:post])
  if current_member == member
    redirect '/'
  else
    redirect "/user/#{member.id}/posts"
  end
end

get '/user/:id/othermembers' do #show all unfriended friends
  redirect '/login' unless current_member
  redirect '/' if current_member.id != params[:id].to_i
  @members = Member.all
  erb :requests
end

get '/user/:id/posts' do #show friend's posts
  redirect '/login' unless current_member
  friend = Member.find(params[:id])
  redirect '/' if !current_member.is_confirmed_friend?(friend)
  @id = friend.id
  @name = friend.full_name
  if current_member.is_confirmed_friend?(friend)
    @posts = friend.posts
  end
  erb :home
end

post '/user/:id/othermembers' do
  Friendship.create(member_id: params[:id], friend_id: params[:friend_id], accepted?: false)
  redirect "/user/#{params[:id]}/othermembers"
end

get '/user/:id/friends' do #show confirmed and pending friends
  redirect '/login' unless current_member
   redirect '/' if current_member.id != params[:id].to_i
  @members = Member.all
  erb :friends
end

post '/user/:id/friends' do 
  friendship = Friendship.where(:member_id => params[:friend_id], :friend_id => params[:id]).take
  friendship.update_attributes(:accepted? => "true")
  friendship.save
  redirect "/user/#{params[:id]}/friends"
end

helpers do 
  def title 
    "Bruno's World"
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
