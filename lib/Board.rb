require 'pry'
require_relative './Ship.rb'
require 'YAML'

class Board
  def initialize(board_file)
    @board_hash = YAML.load(board_file) 
    @active_pos = {}
    @inactive_pos = {}
    @misses = []
  end

  def creat_pos
    @board_hash.each do |name, pos_arr| 
      ship = Ship.new(name)
      pos_arr.each do |pos|
        @active_pos[pos] = ship
      end
    end
  end

  def add_ship(length=Rand(1..4))
    ship = Ship.new(length)
    @ships << ship
    place_ship_randomly(ship)
  end
end
