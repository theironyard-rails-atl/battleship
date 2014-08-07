require 'pry'

class Ship
  attr_reader :name
  def initialize(name)
    @name = name
    @destroyed = false 
  end

  def destroyed?
    @destroyed
  end

end
