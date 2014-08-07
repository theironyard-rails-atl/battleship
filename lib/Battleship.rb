require 'pry'
require_relative './Player.rb'
require_relative './Computer.rb'

class Battleship
  def initialize(hash)
    @player = Player.new(hash[:name])
    @computer = Computer.new(hash[:level])
  end
  def to_s
    @player.board.to_s
  end
end