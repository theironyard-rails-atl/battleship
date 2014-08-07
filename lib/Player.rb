require 'pry'
require_relative './Participant.rb'

class Player < Participant
  attr_reader :name

  def initialize(name)
    @name = name
    super()
  end
  
end