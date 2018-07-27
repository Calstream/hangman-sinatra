require 'sinatra'
require 'sinatra/reloader'

enable :sessions


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

def get_random_word(language, length)
  filepath = ""
  if language == "en"
    filepath = "public/dictionary/en/"
  else
    filepath = "public/dictionary/ru/"
  end
  filepath += length + ".txt"
  random_word = ""
  File.open(filepath) do |file|
    file_lines = file.readlines()
    random_word = file_lines[Random.rand(0...file_lines.size())]
  end
  random_word.upcase
end

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


get '/game' do
  len = params["len"]
  lan = params["lan"]
  word = get_random_word(lan,len)
  if params["lan"] == "en"
    erb :game_en, :locals => {:len => len, :word => word}
  elsif params["lan"] == "ru"
    erb :game_ru, :locals => {:len => len, :word => word}
  end
end
