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
  session[:word] = random_word.upcase
end

get '/' do
  erb :index, :locals => {}
  @session = session
  session[:word] = ""
  session[:lives_left] = 8
  session[:language] = ""
end

get '/settings' do
  msg = ""
  if(params.has_key?(:language) && params.has_key?(:length))
    language = params["language"]
    length = params["length"]
    msg = check_params(language, length)
    if msg == "ok"
      session[:language] = language
      word = get_random_word(language,length)
      redirect "/game", 307
      #erb :settings, :locals => {:msg => "then perish"}
    end
    #throw params.inspect
  end
  erb :settings, :locals => {:msg => msg}
end

get '/game' do
  if session[:language] == "en"
    erb :game_en, :locals => {}
  else
    erb :game_ru, :locals => {}
  end
end
