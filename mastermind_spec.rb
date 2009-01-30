require 'mastermind'

describe Mastermind do
  before(:each) do
    @mastermind = Mastermind.new [1, 2, 3, 4]
  end
  it "should pass when given a correct solution" do
    @mastermind.try [1,2,3,4]
    @mastermind.should be_solved
  end
  it "should fail when given an incorrect solution" do
    @mastermind.try [1,2,3,5]
    @mastermind.should_not be_solved
  end
  it "should indicate when a correct peg is placed" do
    @mastermind.try [1,5,6,7]
    @mastermind.correct_pegs.should == 1
  end
  it "should indicate how many correct pegs were placed" do
    @mastermind.try [1,2,3,5]
    @mastermind.correct_pegs.should == 3
  end
  it "should have all correct pegs for a solved game" do
    @mastermind.try [1,2,3,4]
    @mastermind.correct_pegs.should == @mastermind.game_size
  end
  it "should indicate when a correct color is placed"
end
