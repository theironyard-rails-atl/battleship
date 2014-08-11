# Writing some board specs
require './Board'
require 'minitest/autorun'

describe Board do
  it "knows when ships are hit" do
    board = Board.new("ships.yml")
    assert_equal board.hit?(1,1), "hit"
  end

  it "can show if a place has been hit" do
    board = Board.new("ships.yml")
    board.hit?(4,2)
    assert_equal board.show_hit?(4,2), true
  end

  it "can show if a place has been guessed and was a miss" do
    board = Board.new("ships.yml")
    board.hit?(6,5)
    assert_equal board.show_missed?(6,5), true
  end

  it "knows how many ships are sunk" do
    board = Board.new("ships.yml")
    board.hit?(1,1)
    board.hit?(2,1)
    assert_equal board.count_sunk, 1
  end

  it "knows how many ships are left" do
    board = Board.new("ships.yml")
    board.hit?(1,1)
    board.hit?(2,1)
    assert_equal board.count_remaining, 1
  end
  
end
