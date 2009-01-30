class Mastermind
  def initialize(game)
    @game = game
  end
  def try(game)
    if game == @game then
      @solved = true
    end
  end
  def solved?
    @solved
  end
  def correct_pegs
    1
  end
end
