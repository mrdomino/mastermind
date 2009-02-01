require 'mastermind'

describe Mastermind do

  before do
    @mastermind = Mastermind.new
  end

  describe "color selection" do
    it "should allow specification of the number of colors" do
      [1,2].each do|x|
        foo = Mastermind.new(:colors => x)
        foo.colors.should == x
      end
    end
    it "should default to 6 colors" do
      @mastermind.colors.should == 6
    end
    it "should accept valid color choices"
    it "should reject invalid color choices"
  end

  describe "puzzle generation" do
    it "should allow specification of the number of pegs in a row" do
      [2,3].each do |x|
        foo = Mastermind.new(:pegs => x)
        foo.pegs.should == x
      end
    end
    it "should default to 4 pegs per row" do
      @mastermind.pegs.should == 4
    end
    it "should allow specification of the number of guesses" do
      [2,3].each do |x|
        foo = Mastermind.new(:guesses => x)
        foo.guesses.should == x
      end
    end
    it "should default to 10 guesses" do
      @mastermind.guesses.should == 10
    end

    it "should generate a puzzle with the given parameters" do
      @mastermind.puzzle.size.should == 4
      @mastermind.puzzle.each do |x|
        x.should be_between 1, @mastermind.colors
      end
      foo = Mastermind.new(:pegs => 5)
      foo.puzzle.size.should == 5
    end

    # Lacking the space or drive to implement tests of true randomness
    # (e.g., P(puzzle|past puzzles)=P(puzzle)), we elect that for our
    # purposes puzzles are "random enough" if we don't get the same
    # puzzle multiple times in a row. Psychologists use p < 0.05; this
    # is probably fine. With default settings, there are 6^4 possible
    # Mastermind puzzles; this, being considerably more than 20, means
    # we can just run the test twice.
    it "should generate random puzzles" do
      p1 = Mastermind.new
      p2 = Mastermind.new
      p1.puzzle.should_not == p2.puzzle
    end

    it "should return the same puzzle consistently" do
      @mastermind.puzzle.should == @mastermind.puzzle
    end
  end

  describe "guessing" do
    it "should accept valid solutions"
    it "should not accept invalid solutions"

    describe "hints", :shared => true do
      it "should show 0 pegs if none are right"
      it "should show n pegs if n are right"
    end

    describe "(with correctly-colored pegs in the right place)" do
      it_should_behave_like "hints"
    end

    describe "(with correctly-colored pegs in the wrong place)" do
      it_should_behave_like "hints"
    end
  end
end
