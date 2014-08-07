require 'pry'
require_relative './Board.rb'

class Participant
  attr_accessor :board
  def initialize
    @board = Board.new
  end
end