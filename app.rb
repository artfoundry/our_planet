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
if params[:password] == User.find_by_email(params[:email]).password
    redirect '/home'
  else
    flash[:error] = "Wrong password."
    redirect '/'
  end
end


get "/signup" do
  erb :signup
end

post '/signup' do
  # if params[:password] == params[:password2]
     User.create(firstname: params[:firstname], lastname: params[:lastname], email: params[:email], password: params[:password])
    if params[:password] == params[:password2]
      flash[:success] = "Successfully signed up!"
      redirect '/home'
   else
     flash[:passworderror] = "Passwords don't match!"
      redirect '/signup'
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




