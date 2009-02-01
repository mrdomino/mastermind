class Mastermind
  class << self
    def attr_of_puzzle(*args)
      args.each do |s|
        a = s.to_s
        class_eval "def #{a}; @#{a}; end"
      end
    end
  end
  attr_reader :puzzle
  attr_of_puzzle :colors, :pegs, :guesses

  def initialize(args = {})
    @colors = (args[:colors] or 6)
    @pegs = (args[:pegs] or 4)
    @guesses = (args[:guesses] or 10)
    self.gen_puzzle!
  end

  def gen_puzzle!
    @puzzle = Array.new(self.pegs) { rand(self.colors) + 1 }
  end
end
