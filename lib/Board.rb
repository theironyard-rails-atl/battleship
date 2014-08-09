require 'pry'
require_relative './Ship.rb'
require 'yaml'
require 'pry'

class Board
  attr_reader :size
  attr_accessor :active_pos, :inactive_pos, :misses

  $SHIP_SIZES = {destroyer: 2,
                 submarine: 3,
                 cruiser: 3,
                 battleship: 4,
                 carrier: 5 }

  def initialize(board_file, size=10)
    #@board_arr = YAML::load(File.open(board_file))
    @active_pos = {}
    @inactive_pos = {}
    @misses = []
    @size = size
    create_pos
    console_it
  end

  def create_pos(hash)
    coordinates = hash[:coords]
    ship = Ship.new(hash[:ship])
    coordinates.each do |pos|
      @active_pos[pos] = ship
    end
  end

  def hit?(x,y)
    if @active_pos.include?([x,y])
      hit_obj = @active_pos.select { |key, value| key == [x,y] }
      @active_pos.delete([x,y])
      @inactive_pos.merge!(hit_obj)
      active_ship?(hit_obj[[x,y]]) ? "hit" : "sunk"
    else
      @misses << [x,y]
      "miss"
    end
  end

  def put_ship(hash = {ship: "destroyer", x: 1, y: 1, direction: "horizontal"})
    direction = hash[:direction]
    length = $SHIP_SIZES[hash[:ship].to_sym]
    x = hash[:x]
    y = hash[:y]
    coords = [[x,y]]
    ship = hash[:ship]

    #this creates the pseudo coords based on the direction given
    if direction == "horizontal"
      length.times { |i| coords << [x, y + i] }
    elsif direction == "vertical" |i|
      length.times { coords << [x + i, y] }
    end

    #checking to see if the ship would go off the board
    coords.flatten.each do |x|
      return false if x > (@size - 1)
    end

    #checks to see if any of those pseudo coords are already taken
    coords.each do |x|
      return false if @active_pos.has_key?(x)
    end

    #pass the ship name and coords in hash to the other method
    create_pos(coords: coords, ship: ship)
    return true
  end

  def active_ship?(ship_obj)
    @active_pos.has_value?(ship_obj)
  end

  def show_active_pos?(x,y)
    @active_pos.include?([x,y])
  end

  def show_hit?(x,y)
    @inactive_pos.include?([x,y])
  end

  def show_missed?(x,y)
    @misses.include?([x,y])
  end

  def count_misses
    @misses.count
  end

  def count_hits
    @inactive_pos.count
  end

  def count_sunk
    active_ships = @active_pos.values.uniq
    inactive_ships = @inactive_pos.values.uniq
    inactive_ships.delete_if { |ship|
      active_ships.include?(ship)
    }.count
  end

  def count_remaining
    @active_pos.values.uniq.count
  end

  def game_won?
    @active_pos.count == 0
  end

  def console_it
    puts "Board array is " + @board_arr.to_s
    puts "Active_pos is " + @active_pos.to_s
    puts "Inactive_pos is " + @inactive_pos.to_s
    puts "Misses are " + @misses.to_s
  end

#   Temp stuff
  def put_ship(hash)
    [true, false].sample

  end
end
