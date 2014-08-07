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

  def place_ship_randomly(ship)
    #TODO logic to place ship
  end

  def to_s
    output = ""
    @board.count.times do
      output += "-----"
    end
    output += " <br> "
    @board.each do |row|
      row.each do |element|
        output += "| #{element} |"
      end
      output += " <br> "
      row.count.times do
        output += "-----"
      end
      output += " <br> "
    end
    output
  end
end
