require 'sinatra'
require 'haml'
require './lib/Battleship.rb'


enable :sessions

get '/' do
  haml :index, :locals => { :request => request }
end

get '/setup' do
  if session[:game]
    x = request["x"].to_i
    y = request["y"].to_i
    direction = request["direction"]
    binding.pry
    session[:player].board.put_ship( :ship => "", :x => x, :y => y, :direction => direction )
    haml :setup, :local => { :request => request}
  else
    session[:game] = Battleship.new(:name => request[:name])
    session[:player] = session[:game].player1
    haml :setup, :local => { :request => request }
  end
end

get '/game' do
  x = request["x"].to_i
  y = request["y"].to_i
  result = session[:player].fire(x, y)
  haml :playing, :locals => { :request => request, :result => result }
end

get '/about' do
  haml :about
end

helpers do
  def cell_class(x, y)
    if session[:player].board.show_hit?(x, y)
      "hit"
    elsif session[:player].board.show_missed?(x, y)
      "missed"
    else
      "blank"
    end
  end
end
