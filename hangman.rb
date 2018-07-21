require 'sinatra'
require 'sinatra/reloader'

word_length = 0

get '/' do
  erb :index, :locals => {}
end

post '/settings' do
  erb :settings, :locals => {:word_length => word_length}
end

get '/game' do
  erb :game, :locals => {}
end
