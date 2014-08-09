require 'pry'
require_relative './Participant.rb'

class Battleship
  attr_accessor :player1

  def initialize(hash)
    @player1 = Player.new(hash[:name])
    @player2 = nil
  end

  def add_second_player(name)
    @player2 = Player.new(name)
  end
end
