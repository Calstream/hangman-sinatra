require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :index, :locals => {}
end

get '/new_game' do
  erb :new_game, :locals => {}
end

get '/game' do
  erb :game, :locals => {}
end
