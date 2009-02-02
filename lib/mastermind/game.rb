module Mastermind

class Game
  attr_reader :puzzle
  attr_reader :colors, :pegs, :guesses

  def initialize(args = {})
    @colors = args[:colors] || 6
    @pegs = args[:pegs] || 4
    @guesses = args[:guesses] || 10
    @puzzle = args[:puzzle] || Array.new(pegs) { rand(colors) + 1 }

    @guess = []
  end

  def guess!(p)
    if self.solved? then
      raise "This puzzle has already been solved. You can stop guessing now!"
    end
    if @guess.size == @guesses then
      raise "You haven't solved this puzzle. Better luck next time!"
    end
    validate p
    @guess << p
    @solved = p == puzzle
  end

  def validate(p)
    p.size == pegs or raise "Solutions should be of size #{pegs}; received solution of size #{p.size}"
    p.each do |i|
      i.between? 1, colors or raise "#{i} is out of bounds; should be in [1,#{colors}]"
    end
  end

  def solved?
    @solved
  end

  def pegs_correct(n=-1)
    return puzzle.zip(guess(n)).inject(0) do |acc,i|
      acc = acc + 1 if i.reduce(:==)
      acc
    end
  end

  def colors_correct(n=-1)
    t1 = Array.new(colors,0)
    t2 = Array.new(colors,0)
    puzzle.zip(guess n).each do |i,j|
      if i != j then
        t1[i-1] += 1
        t2[j-1] += 1
      end
    end
    t1.zip(t2).inject(0) do |acc,x|
      acc = acc + 1 if x.all? {|z| z > 0}
      acc
    end
  end

  def guess(n=-1)
    @guess[n]
  end

  def hints(n=-1)
    [pegs_correct(n),colors_correct(n)]
  end

private

  def last
    @guess[-1]
  end
end

end