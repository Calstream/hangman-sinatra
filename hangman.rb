require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :index, :locals => {}
end

get '/settings' do
  msg = ""
  if(params.has_key?(:language) && params.has_key?(:length))
    language = params["language"]
    length = params["length"]
    msg = check_params(language, length)
    if msg == "ok"
      redirect "/game?lan=#{language}&len=#{length}"
      #erb :settings, :locals => {:msg => "then perish"}
    end
    #throw params.inspect
  end
  erb :settings, :locals => {:msg => msg}
end

post '/game' do
  erb :game, :locals => {:lan => "", :len => 0}
end

def check_params(language, length)
  msg = "ok"
  if ((length.to_i).between?(4,10))
    if language == "none"
      msg = "You need to select a language"
    elsif language != "en" and language != "ru"
      msg = "Don't do that."
    end
  else
    msg = "Don't do that."
  end
  msg
end

get '/game' do
  if params["lan"] == "en"
    erb :game_en, :locals => {}
  elsif params["lan"] == "ru"
    erb :game_ru, :locals => {}
  end
  erb :game, :locals => {}
end
