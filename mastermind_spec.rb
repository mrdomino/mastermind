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
    it "should accept valid color choices" do
      lambda { @mastermind.guess! [3,3,3,3] }.should_not raise_error
    end
    it "should reject invalid color choices" do
      lambda { @mastermind.guess! Array.new 4, (-1) }.should raise_error
      lambda {
        @mastermind.guess! Array.new 4, @mastermind.colors + 1
      }.should raise_error
    end
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
    it "should accept valid solutions" do
      @mastermind.guess!(@mastermind.puzzle.dup)
      @mastermind.should be_solved
    end
    it "should not accept invalid solutions" do
      foo = Mastermind.new :puzzle => [1,2,3,4]
      foo.guess! [5,6,5,6]
      foo.should_not be_solved
    end

    it "should not accept anything else after a valid solution" do
      trytosolve = lambda { @mastermind.guess!(@mastermind.puzzle.dup) }
      trytosolve.call
      trytosolve.should raise_error
    end
    it "should not accept more than the maximum number of guesses" do
      10.times { @mastermind.guess! [1,2,3,4] }
      lambda { @mastermind.guess! [1,2,3,4] }.should raise_error
    end

    describe "hints", :shared => true do
      before do
        @testp = Mastermind.new :puzzle => [1,2,3,4]
        @hintfunc = @um_hintfunc.bind(@testp)
      end
      it "should show 0 pegs if none are right" do
        @testp.guess! @none_soln
        @hintfunc.call.should == 0
      end
      it "should show n pegs if n are right" do
        @testp.guess! @n_soln
        @hintfunc.call.should == @n
      end
    end

    describe "(with correctly-colored pegs in the right place)" do
      before do
        @none_soln = [4,3,2,1]
        @n_soln = [1,2,5,6]
        @n = 2
        @um_hintfunc = Mastermind.instance_method(:pegs_correct)
      end
      it_should_behave_like "hints"
    end

    describe "(with correctly-colored pegs in the wrong place)" do
      before do
        @none_soln = [5,6,5,6]
        @n_soln = [4,3,2,1]
        @n = 4
        @um_hintfunc = Mastermind.instance_method(:colors_correct)
      end
      it_should_behave_like "hints"
    end
  end
end
