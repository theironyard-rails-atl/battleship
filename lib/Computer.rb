require 'pry'
require_relative './Participant.rb'

class Computer < Participant

  def initialize(level=1)
    @level = level
    super()
  end

end