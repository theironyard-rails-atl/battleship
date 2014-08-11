require 'sinatra'
require 'haml'
require './lib/Battleship.rb'

configure :development do
  set(:session_secret, 'a random string that wont change')
end

configure :production do
  set(:session_secret, '*&(${)UIJH$(&*(&*(@(*)(!)))IUYA0984)})')
end

configure do
  enable :sessions
end

get '/' do
  session[:game] = nil
  haml :index, :locals => { :request => request }
end

get '/setup' do
  if session[:game] #means that there is a game object
    result = session[:player].board.put_ship( :x => request["x"].to_i, :y => request["y"].to_i, :direction => request["direction"] )

    if session[:player].board.ships_not_set.empty?
      redirect to('/game', "")
      #haml :game, :locals => { :request => request, :result => result, :computer => session[:game].computer }
    else
      haml :setup, :locals => { :request => request, :result => result}
    end

  else #means there is no game object
    session[:game] = Battleship.new(:name => request[:name])
    session[:player] = session[:game].player
    haml :setup, :locals => { :request => request, :result => ""}
  end
end

get '/game' do
  if request["x"] && request["y"]
    x = request["x"].to_i
    y = request["y"].to_i
    player_result = session[:game].computer.fire(x, y)
    computer_result = session[:game].player.fire
    session[:game].toggle_turn
  end
  haml :game, :locals => { :request => request, :player_result => player_result, :computer_result => computer_result, :computer => session[:game].computer}
end

get '/about' do
  haml :about
end

helpers do
  def cell_class(x, y, player)
    if player.board.show_hit?(x, y)
      "hit"
    elsif player.board.show_missed?(x, y)
      "missed"
    elsif (player == session[:player]) && already_placed?(x,y)
      "placed"
    else
      "blank"
    end
  end

  def already_placed?(x, y)
    session[:player].board.in_active_pos?(x,y)
  end
end
