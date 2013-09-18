require 'sinatra'

get '/' do
  erb :home
end

helpers do 
  def title 
    "Our Planet"
  end
end
