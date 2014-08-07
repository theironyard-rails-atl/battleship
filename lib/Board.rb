require 'pry'
require_relative './Ship.rb'
require 'YAML'

class Board
  attr_reader :size
  attr_accessor :active_pos, :inactive_pos, :misses
  
  def initialize(board_file, size)
    @board_arr = YAML::load(File.open(board_file))
    @active_pos = {}
    @inactive_pos = {}
    @misses = []
    @size = size
  end

  def create_pos
    @board_arr.each do |name, pos_arr|
      ship = Ship.new(name)
      pos_arr.each do |pos|
        @active_pos[pos] = ship
      end
    end
  end

  def hit?(x,y)
    if @active_pos.include?([x,y])
      @inactive_pos.push(@active_pos.delete_if { |key, value| key == [x,y] })
      true
    else
      @misses.push(@active_pos.delete_if { |key, value| key == [x,y] })
      false
    end
  end

  # def hit_destroys_ship?
  #   if hit? &&  
  #   end

  def show_hit?(x,y)
    @inactive_pos.include?([x,y])
  end

  def show_miss?(x,y)
    @misses.include?([x,y])
  end
end
