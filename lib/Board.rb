require 'pry'
require_relative './Ship.rb'
require 'YAML'

class Board
  attr_reader :size
  attr_writer :active_pos, :inactive_pos, :misses, 
  def initialize(board_file, size)
    @board_arr = YAML::load(File.open(board_file)) 
    @active_pos = {}
    @inactive_pos = {}
    @misses = []
    @size = size
  end

  def creat_pos
    @board_arr.each do |name, pos_arr| 
      ship = Ship.new(name)
      pos_arr.each do |pos|
        @active_pos[pos] = ship
      end
    end
  end
end
