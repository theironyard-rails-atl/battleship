require 'sinatra'
require 'Haml'
require './lib/Battleship.rb'


enable :sessions

get '/' do
  if request["new_player_name"]
    name = request[:new_player_name]
    level = request[:level]
    session[:game] = Battleship.new(:name => name, :level => level)
    %{#{session[:game].to_s}}
  else
    %{This is the basic page <br> <form method="get" action="http://#{request.host}:#{request.port}/">
            Your Name <input type="text" name="new_player_name" placeholder="Enter your name" autofocus>
            Level (between 1 and 3): <input type="number" name="level" value= "1" min="1" max="3">
            <input type="submit">
          </form>}
  end
end


