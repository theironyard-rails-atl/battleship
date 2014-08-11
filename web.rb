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
  # session[:game] = nil
  haml :index, :locals => { :request => request }
end

get '/setup' do
  if session[:game] #means that there is a game object
    result = session[:player].board.put_ship( :x => request["x"].to_i, :y => request["y"].to_i, :direction => request["direction"] )

    if session[:player].board.ships_not_set.empty? && session[:game].player2
      haml :game, :locals => { :request => request, :result => result, :opponent => get_opponent }
    elsif session[:player].board.ships_not_set.empty?
      haml :waiting, :locals => { :request => request, :result => ""}
    else
      haml :setup, :locals => { :request => request, :result => result}
    end

  else #means there is no game object
    session[:game] = Battleship.new(:name => request[:name])
    session[:player] = session[:game].player1
    haml :setup, :locals => { :request => request, :result => ""}
  end
end

get '/game' do
  if request["identifier"]
    find_game_object(request["identifier"])
  end
  if session[:game]
    if request["x"] && request["y"]
      x = request["x"].to_i
      y = request["y"].to_i
      result = get_opponent.fire(x, y)
    end
    haml :game, :locals => { :request => request, :result => result, :opponent => get_opponent}
  else
    haml :waiting, :locals => { :request => request }
  end
end

get '/:game_id' do
  if find_game_object(params[:game_id])
    haml :setup, :locals => { :request => request, :result => "" }
  else
    haml :invalid_game, :locals => { :request => request }
  end
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

  def get_opponent
    if session[:player] == session[:game].player1
      session[:game].player2
    else
      session[:game].player1
    end
  end

  def find_game_object(game_id)
    Battleship.instances.each do |game_object|
      if (game_object.identifier.to_s == game_id)
        session[:game] = game_object
        set_second_player if !game_object.player2
        return true
      end
    end
    return false
  end

  def set_second_player
      session[:player] = Player.new
      session[:game].player2 = session[:player]
  end
end
