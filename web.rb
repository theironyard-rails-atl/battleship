require 'sinatra'
require 'Haml'
require './lib/Battleship.rb'


enable :sessions

get '/' do
  if request["new_player_name"]
    name = request[:new_player_name]
    session[:game] = Battleship.new(:name => name)
    message = false
    haml :playing, :locals => { :game => session[:game], :request => request, :message => message }
  elsif request["playing"]
    x = request["x"]
    y = request["y"]
    message = session[:game].player.fire(x, y)
    haml :playing, :locals => { :game => session[:game], :request => request, :message => message }
  else
    haml :index, :locals => { :request => request }
  end
end

get '/about' do
  haml :about
end

helpers do
  def cell_class(x, y)
    if session[:game].player.board.show_hit?(x, y)
      "hit"
    elsif session[:game].player.board.show_missed?(x, y)
      "missed"
    else
      "blank"
    end
  end
end
