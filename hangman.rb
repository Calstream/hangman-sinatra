require 'sinatra'
require 'sinatra/reloader'

word_length = 0

get '/' do
  erb :index, :locals => {}
end

get '/settings' do
  msg = ""
  language = params["language"]
  length = params["length"]
  if params["language"] == "none"
    msg = "You need to select a language"
  end
  throw params.inspect

  erb :settings, :locals => {:msg => msg}
end

post '/game' do
  erb :game, :locals => {}
end
