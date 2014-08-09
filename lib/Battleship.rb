require 'pry'
require_relative './Participant.rb'

class Battleship
  attr_accessor :player1, :player2

  def initialize(hash)
    @player1 = Player.new(hash[:name])
    @player2 = nil
    @current_turn = @player1
  end

  def toggle_turn
    if @current_turn == @player1
      @current_turn = @player2
    else
      @current_turn = @player1
    end
  end

  def self.all; ObjectSpace.each_object(self).to_a end
end
