require 'pry'

class Ship
  attr_reader :name
  attr_accessor :destroyed
  
  def initialize(name)
    @name = name
    @destroyed = false 
  end

  def destroyed?
    @destroyed 
  end

end
