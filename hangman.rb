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

def guess(char)
  ind = session[:word].index(char)
  if ind == nil
    session[:attempts_left] -= 1
  else
    indices = (0 ... session[:word].length).find_all { |i| session[:word][i] == char }
    indices.each do |ind|
      session[:dashes][ind] = char
    end
  end
end

get '/' do
  @session = session
  session[:word] = ""
  session[:attempts_left] = -1
  session[:language] = ""
  session[:dashes] = ""
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
      session[:dashes] = ""
      i = 2
      until i > session[:word].length do
        session[:dashes] += "_"
        i += 1
      end
      session[:set] = true
      redirect "/game"
    end
  end

  erb :settings, :locals => {:msg => msg}
end

get '/game' do
  if session[:set]
    if session[:attempts_left] == 0 or session[:dashes].index("_") == nil
      redirect "/gameover"
    end
    erb :game, :locals => {}
    #throw params.inspect
  else
    redirect "/"
  end
end

get '/gameover' do
  erb :gameover, :locals => {}
end

(1..32).each do |keynum|
get "/key_#{keynum}" do
  char = ""
  if session[:language] == "en"
    char = ("A".ord + keynum - 1).chr
  else
    char = ("А".ord + keynum - 1).chr
  end
  guess(char)
  redirect "/game"
end
end
