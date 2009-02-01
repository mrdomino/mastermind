class Mastermind
  attr_reader :puzzle
  attr_reader :colors, :pegs, :guesses

  def initialize(args = {})
    @colors = args[:colors] || 6
    @pegs = args[:pegs] || 4
    @guesses = args[:guesses] || 10
    @puzzle = args[:puzzle] || Array.new(self.pegs) { rand(self.colors) + 1 }

    @guesses_made = 0
  end

  def guess!(p)
    if self.solved? then
      raise "This puzzle has already been solved. You can stop guessing now!"
    end
    if @guesses_made == @guesses then
      raise "You haven't solved this puzzle. Better luck next time!"
    end
    @solved = p == self.puzzle
    @guesses_made += 1
  end

  def solved?
    @solved
  end
end
