require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/partial'

enable :sessions

enable :partial_underscores
set :partial_template_engine, :erb

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
  @session = session
  session[:word] = ""
  session[:attempts_left] = -1
  session[:language] = ""
  session[:set] = false
  erb :index, :locals => {}
end

get '/settings' do
  msg = ""
  if(params.has_key?(:language) && params.has_key?(:length))
    language = params["language"]
    length = params["length"]
    msg = check_params(language, length)
    if msg == "ok"
      session[:language] = language
      session[:word] = get_random_word(language,length)
      session[:attempts_left] = 8
      session[:set] = true
      redirect "/game"
      #erb :settings, :locals => {:msg => "then perish"}
    end
    #throw params.inspect
  end
  erb :settings, :locals => {:msg => msg}
end

get '/game' do
  if session[:set]
  #body = partial :"partials/game"
    #throw params.inspect
    erb :game, :locals => {}
  else
    redirect "/"
  end
end
