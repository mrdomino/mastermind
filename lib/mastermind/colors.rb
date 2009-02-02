module Mastermind

class Colors

  def self.colors(n)
    1.upto(n).collect do |i|
      hue2rgb (360.0*i/n)
    end
  end

private

  def self.hue2rgb h
    h = (h.to_f / 60 + 1e-3) % 6
    c = h % 1
    case h
    when 0..1: rgb(1.0, c,   0.0)
    when 1..2: rgb(1-c, 1.0, 0.0)
    when 2..3: rgb(0.0, 1.0, c  )
    when 3..4: rgb(0.0, 1-c, 1.0)
    when 4..5: rgb(c,   0.0, 1.0)
    when 5..6: rgb(1.0, 0.0, 1-c)
    end
  end

end

end
