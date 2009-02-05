require File.join(File.dirname(__FILE__), %w(.. spec_helper))

require 'mastermind/game'

describe Mastermind::Game do

  before do
    @mastermind = Mastermind::Game.new
  end

  describe "color selection" do
    it "should allow specification of the number of colors" do
      [1,2].each do|x|
        foo = Mastermind::Game.new(:colors => x)
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
        foo = Mastermind::Game.new(:pegs => x)
        foo.pegs.should == x
      end
    end
    it "should default to 4 pegs per row" do
      @mastermind.pegs.should == 4
    end
    it "should allow specification of the number of guesses" do
      [2,3].each do |x|
        foo = Mastermind::Game.new(:guesses => x)
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
      foo = Mastermind::Game.new(:pegs => 5)
      foo.puzzle.size.should == 5
    end

    # With default settings, there are 6^4 possible Mastermind puzzles;
    # that means that this test will fail erroneously about .08% of the
    # time.
    it "should generate random puzzles" do
      p1 = Mastermind::Game.new
      p2 = Mastermind::Game.new
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
      foo = Mastermind::Game.new :puzzle => [1,2,3,4]
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
    it "should tell when the game is lost" do
      10.times { @mastermind.guess! [1,2,3,4] }
      @mastermind.should be_lost
      @mastermind.should_not be_solved
    end
    # an optimistic test
    it "should not be lost with no guesses" do
      @mastermind.should_not be_lost
    end
    it "should not be lost when it is solved on the last guess" do
      9.times { @mastermind.guess! [1,2,3,4] }
      @mastermind.guess! @mastermind.puzzle
      @mastermind.should_not be_lost
    end

    describe "hints", :shared => true do
      before do
      end
      it "should show n pegs if n are right" do
        @puzzles.each do |p|
          m = Mastermind::Game.new :puzzle => p[:puzzle]
          hints = @um_hintfunc.bind(m)
          m.guess! p[:guess]
          hints.call.should == p[:n]
        end
      end
    end

    describe "hints (in general)" do
      it "should give hints in array format" do
        foo = Mastermind::Game.new :puzzle => [1,2,3,4]
        foo.guess! [1,2,4,6]
        foo.hints[-1].should == [foo.pegs_correct, foo.colors_correct]
      end
    end

    describe "hints (with correctly-colored pegs in the right place)" do
      before do
        @puzzles = [{:n => 0, :puzzle => [1,2,3,4], :guess => [4,3,2,1]},
                    {:n => 2, :puzzle => [1,2,3,4], :guess => [1,2,5,6]}]
        @um_hintfunc = Mastermind::Game.instance_method(:pegs_correct)
      end
      it_should_behave_like "hints"
    end

    describe "hints (with correctly-colored pegs in the wrong place)" do
      before do
        @puzzles = [{:n => 0, :puzzle => [1,2,3,4], :guess => [5,6,5,6]},
                    {:n => 1, :puzzle => [1,2,3,4], :guess => [1,4,6,5]},
                    {:n => 0, :puzzle => [2,2,2,1], :guess => [2,2,2,2]},
                    {:n => 3, :puzzle => [1,2,1,4], :guess => [5,1,2,1]},
                    {:n => 1, :puzzle => [1,2,2,1], :guess => [2,3,3,3]}]
        @um_hintfunc = Mastermind::Game.instance_method(:colors_correct)
      end
      it_should_behave_like "hints"
    end
  end

  describe "old guesses" do
    it "should give access to old guesses" do
      @mastermind.guess! [1,2,3,4]
      @mastermind.guess! [5,6,1,2]
      @mastermind.guess[0].should == [1,2,3,4]
      @mastermind.guess[1].should == [5,6,1,2]
    end
    it "should provide hints for old guesses" do
      foo = Mastermind::Game.new :puzzle => [1,2,3,4]
      foo.guess! [1,4,6,5]
      foo.guess! [5,6,5,6]
      foo.hints[0].should == [1,1]
      foo.hints[1].should == [0,0]
    end
  end
end
