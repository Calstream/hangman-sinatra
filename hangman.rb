require 'sinatra'
require 'sinatra/reloader'

get '/' do
  "Hello bitch"
  erb :index, :locals => {}
end
