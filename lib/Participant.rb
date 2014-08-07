require 'pry'
require_relative './Board.rb'



class Participant
  attr_accessor :board
  def initialize
    @board = Board.new("ships.yml", [6,6])
  end
end


class Computer < Participant

  def initialize(name="comp")
    @name = name
    super()
  end

  def fire
    return [rand(0..5), rand(0..5)]
  end

end

class Player < Participant
  attr_reader :name

  def initialize(name = "Tay")
    @name = name
    super()
  end

  def fire (c1, c2)
    @board.hit?(c1, c2)
  end

end
