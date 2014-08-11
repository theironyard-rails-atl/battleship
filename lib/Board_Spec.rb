# Writing some board specs
require './Board'
require 'minitest/autorun'

describe Board do
  it "can position ships properly" do
    board = Board.new()
    board.put_ship([name: "destroyer", direction: vertical, x: 0, y: 0])
    position = board.show_active_pos?(0,0)
    assert_equal position, true
  end

  it "knows when ships are hit" do
    board = Board.new
    board.put_ship([name: "destroyer", direction: vertical, x: 0, y: 0])
    board.create_pos
    assert_equal board.hit?(1,1), true
  end

  it "can show if a place has been hit" do
    board = Board.new("ships.yml", [6,6])
    board.create_pos
    board.hit?(4,2)
    assert_equal board.show_hit?(4,2), true
  end

  it "can show if a place has been guessed and was a miss" do
    board = Board.new("ships.yml", [6,6])
    board.create_pos
    board.hit?(6,5)
    assert_equal board.show_miss?(6,5), true
  end
end
