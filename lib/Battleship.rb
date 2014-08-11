require 'pry'
require_relative './Participant.rb'

class Battleship
  attr_accessor :player, :computer, :identifier

  def initialize(hash)
    @player = Player.new(hash[:name])
    @computer = Computer.new
    @current_turn = @player1
  end

  def toggle_turn
    if @current_turn == @player
      @current_turn = @computer
    else
      @current_turn = @player
    end
  end
end
