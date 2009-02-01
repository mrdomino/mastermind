class Mastermind
  attr_reader :puzzle
  attr_reader :colors, :pegs, :guesses

  def initialize(args = {})
    @colors = args[:colors] || 6
    @pegs = args[:pegs] || 4
    @guesses = args[:guesses] || 10
    @puzzle = args[:puzzle] || Array.new(self.pegs) { rand(self.colors) + 1 }
  end

  def guess!(p)
    if self.solved? then
      raise "This puzzle has already been solved. You can stop guessing now!"
    end
    @solved = p == self.puzzle
  end

  def solved?
    @solved
  end
end
