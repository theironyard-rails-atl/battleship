require 'pry'
require_relative './Participant.rb'

class Battleship

  @@instances = []

  def self.instances
    @@instances
  end

  attr_accessor :player1, :player2, :identifier

  def initialize(hash)
    @player1 = Player.new(hash[:name])
    @player2 = nil
    @current_turn = @player1
    @identifier = Random.rand(1000000000)
    @@instances << self
  end

  def toggle_turn
    if @current_turn == @player1
      @current_turn = @player2
    else
      @current_turn = @player1
    end
  end

end
