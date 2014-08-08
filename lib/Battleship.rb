require 'pry'
require_relative './Participant.rb'

class Battleship
  attr_accessor :player, :computer

  def initialize(hash)
    @player = Player.new(hash[:name])
    @computer = Computer.new(hash[:level])
  end
  def to_s
    @player.board.to_s
  end
end
