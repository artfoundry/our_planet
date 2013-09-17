require 'sinatra'
require 'time'
require "sinatra/activerecord"
require_relative 'app/models/post'


helpers do 
  def title 
    "Our Planet"
  end
  
  def format_time(time)
    time.strftime("%H:%M, %d %b %Y") 
  end
end


get "/" do
  @posts = Post.order("created_at DESC")
  erb :"default"
end

post '/' do
  n = Post.create(text: params[:text])
  redirect '/'
end



