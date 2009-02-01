class Mastermind
  attr puzzle
  attr_accessor :colors, :pegs, :guesses
  def initialize
    self.colors = 6
    self.pegs = 4
    self.guesses = 10
  end
  def puzzle
    Array.new(self.pegs) { rand(self.colors - 1) + 1 }
  end
end
