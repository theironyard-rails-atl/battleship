require 'sinatra'
require 'haml'
require './lib/Battleship.rb'


enable :sessions

get '/' do
  session[:game] = nil
  haml :index, :locals => { :request => request }
end

get '/setup' do
  if session[:game]
    x = request["x"].to_i
    y = request["y"].to_i
    direction = request["direction"]
    result = session[:player].board.put_ship( :x => x, :y => y, :direction => direction )
    if session[:player].board.ships_not_set.empty? && session[:game].player2
      if session[:player] == session[:game].player1
        opponent = session[:game].player2
      else
        opponent = session[:game].player1
      end
      haml :game, :locals => { :request => request, :result => result, :opponent => opponent }
    elsif session[:player].board.ships_not_set.empty?
      haml :waiting, :locals => { :request => request, :result => ""}
    else
      haml :setup, :locals => { :request => request, :result => result}
    end
  else
    session[:game] = Battleship.new(:name => request[:name])
    session[:player] = session[:game].player1
    haml :setup, :locals => { :request => request, :result => ""}
  end
end

get '/game' do
  if session[:game].player2
    if session[:player] == session[:game].player1
      opponent = session[:game].player2
    else
      opponent = session[:game].player1
    end
    x = request["x"].to_i if request["x"]
    y = request["y"].to_i if request["y"]
    result = opponent.fire(x, y) if (x && y)
    haml :game, :locals => { :request => request, :result => result, :opponent => opponent}
  else
    haml :waiting, :locals => { :request => request }
  end
end

get '/:game_id' do
  Battleship.all.each do |game_object|
    if (game_object.object_id.to_s == params[:game_id]) && !game_object.player2
      session[:game] = game_object
      session[:player] = Player.new
      session[:game].player2 = session[:player]
      return haml :setup, :locals => { :request => request, :result => ""}
    end
  end
  haml :invalid_game, :locals => { :request => request }
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
    else
      "blank"
    end
  end

  def already_placed?(x, y)
    session[:player].board.in_active_pos?(x,y)
  end
end
