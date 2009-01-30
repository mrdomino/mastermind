require 'mastermind'

describe Mastermind do

  describe "color selection" do
    it "should allow specification of the number of colors"
    it "should default to 6 colors"
    it "should accept valid color choices"
    it "should reject invalid color choices"
  end

  describe "guessing" do
    it "should allow specification of the number of pegs in a row"
    it "should default to 4 pegs per row"
    it "should allow specification of the number of guesses"
    it "should default to 10 guesses"
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
