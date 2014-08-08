require_relative './Ship.rb'

module BOARDTOSTRING
  ship1 = Ship.new(2)
  ship2 = Ship.new(3)

  SAMPLE_ACTIVE_POS = {[0, 1] => ship1, [1, 5] => ship2, [3, 5] => ship2}
  SAMPLE_INACTIVE_POS = {[0, 0] => ship1, [2, 5] => ship2}
  RANDOM_MISSES_ARRAY = [[5,5], [4,5]]

  def to_s

  end
end


  #This is the old method that renders a board with space
=begin
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
=end
