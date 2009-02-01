class Mastermind
  attr_reader :puzzle
  attr_reader :colors, :pegs, :guesses

  def initialize(args = {})
    @colors = (args[:colors] or 6)
    @pegs = (args[:pegs] or 4)
    @guesses = (args[:guesses] or 10)
    @puzzle = (args[:puzzle] or Array.new(self.pegs) { rand(self.colors) + 1 })
  end

  def guess!(p)
    @solved = p == self.puzzle
  end

  def solved?
    @solved
  end
end
