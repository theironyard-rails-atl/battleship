





# require 'pry'
# require_relative './Ship.rb'
#
# class Board
#   def initialize(size=5)
#     @ships = []
#     @board = []
#     size.times do
#       @board << []
#     end
#     @board.each do |array|
#       size.times do
#         array.push " "
#       end
#     end
#   end
#
#
#   def add_ship(length=Rand(1..4))
#     ship = Ship.new(length)
#     @ships << ship
#     place_ship_randomly(ship)
#   end
#
#   def place_ship_randomly(ship)
#     #logic to place ship
#   end
#
#   def to_s
#     output = ""
#     @board.count.times do
#       output += "-----"
#     end
#     output += " <br> "
#     @board.each do |row|
#       row.each do |element|
#         output += "| #{element} |"
#       end
#       output += " <br> "
#       row.count.times do
#         output += "-----"
#       end
#       output += " <br> "
#     end
#     output
#   end
# end
