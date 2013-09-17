require 'sinatra'
require 'time'
require "sinatra/activerecord"
require_relative 'models/post'


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
  erb :home
end

post '/' do
  Post.create(title: params[:title], text: params[:text])
  redirect '/'
end

get '/:id' do
  @post = Post.find params[:id]
  @title = "Edit post #{@post.title}"
  erb :edit
end

put '/:id' do
  p = Post.find params[:id]
  p.title = params[:title]
  p.text = params[:text]
  p.updated_at = Time.now
  p.save
  redirect '/'
end

get '/:id/delete' do
  @post = Post.find params[:id]
  @title = "Confirm deletion of #{@post.title}"
  erb :delete
end

delete '/:id' do
  Post.find(params[:id]).destroy
  redirect '/'
end
