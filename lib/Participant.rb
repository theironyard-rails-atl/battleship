require 'pry'
require_relative './Board.rb'



class Participant
  attr_accessor :board
  def initialize(yaml = nil)
    @board = Board.new(yaml)
  end
end


class Computer < Participant

  def initialize(name="Computer")
    @name = name
    super("./public/ships.yml")
    @board.create_comp_pos
  end

  def fire
    return [rand(0..@board.size), rand(0..@board.size)]
  end

end

class Player < Participant
  attr_reader :name

  def initialize(name = "Anonymous")
    @name = name
    super()
  end

  def fire (x, y)
    @board.hit?(x, y)
  end
end
