require File.join(File.dirname(__FILE__), %w(.. spec_helper))

require 'mastermind/colors'

describe Mastermind::Colors do
  before do
    @color_szs = [6,8,10]
    @colorss = @color_szs.collect {|n| Mastermind::Colors.colors n }
  end

  it "should return a list of the specified length" do
    @colorss.zip(@color_szs).each {|cs,sz| cs.size.should == sz }
  end
  it "should return a unique list of colors" do
    @colorss.each do |cs|
      cs.dup.each_with_index do |x,i|
        cs.each_with_index do |y,j|
          x.should_not == y unless i == j
        end
      end
    end
  end
  it "should return colors in RGB format" do
    @colorss.each do |cs|
      cs.each do |c|
        c.size.should == 3
        c.each {|x| x.should be_between 0,1 }
      end
    end
  end
end
