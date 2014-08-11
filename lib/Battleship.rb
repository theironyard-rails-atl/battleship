require 'pry'
require_relative './Participant.rb'

class Battleship

=begin
  @@instances = []

  def self.instances
    @@instances
  end
=end

  attr_accessor :player, :computer, :identifier

  def initialize(hash)
    @player = Player.new(hash[:name])
    @computer = Computer.new
    @current_turn = @player1
    # @identifier = Random.rand(1000000000)
    # @@instances << self
  end

  def toggle_turn
    if @current_turn == @player
      @current_turn = @computer
    else
      @current_turn = @player
    end
  end

end
