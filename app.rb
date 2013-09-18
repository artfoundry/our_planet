require 'sinatra'
require 'time'
require "sinatra/activerecord"
require_relative 'app/models/user'
require_relative 'app/models/post'
require 'shotgun'
require 'sinatra/flash'  
require 'sinatra/redirect_with_flash' 

enable :sessions  


helpers do 
  def title 
    "Our Planet"
  end

  def heading
    "Welcome to Jon and Nishant's Planet!"
  end
  
  def format_time(time)
    time.strftime("%H:%M, %d %b %Y") 
  end
end

get "/" do
  erb :login
end

post '/' do
  if User.find_by_email(params[:email]) == nil
    flash[:error] = "Invalid login information."
    redirect '/'
  elsif params[:password] == User.find_by_email(params[:email]).password
    u = User.find_by_email(params[:email])
    flash[:welcome] = "Welcome back #{u.firstname}!"
    redirect '/home'
  else
    flash[:error] = "Invalid login information."
    redirect '/'
  end
end


get "/signup" do
  @user = User.new
  erb :signup
end

post '/signup' do
  @user = User.create(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], password: params[:password])
  if @user.valid? && params[:password] == params[:password2]
    flash[:success] = "Successfully signed up!"
    redirect '/home'
  else
    erb :signup
  end
end

get '/home' do
  @posts = Post.order("created_at DESC")
  erb :default
end

post '/home' do
  Post.create(text: params[:text])
  redirect '/home'
end




