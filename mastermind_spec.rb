require 'mastermind'

describe Mastermind do
  before(:each) do
    @mastermind = Mastermind.new [1, 2, 3, 4]
  end
  it "should pass when given a correct solution" do
    @mastermind.try [1,2,3,4]
    @mastermind.should be_solved
  end
  it "should fail when given an incorrect solution"
  it "should indicate when a correct peg is placed"
  it "should indicate when a correct color is placed"
end
