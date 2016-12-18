require_relative 'setting'

class Puyo < Sprite

  attr_accessor :parent, :colorindex

  PUYOCOLORS = [
	  Image.new($IMG_WIDTH, $IMG_HEIGHT, [200,255, 255, 0]),
	  Image.new($IMG_WIDTH, $IMG_HEIGHT, [200,255, 0, 0]),
	  Image.new($IMG_WIDTH, $IMG_HEIGHT, [200,0, 255, 0]),
	  Image.new($IMG_WIDTH, $IMG_HEIGHT, [200,0, 0, 255])
  ]

  def initialize(x, y, colorindex,parent)
    super(x, y, PUYOCOLORS[colorindex])
    @colorindex = colorindex
    self.parent = parent
  end

  def update
    if self.parent.get_achieve == false
      self.y += 1 if self.y < $BOTTOM - $IMG_HEIGHT
    end
  end

  def shot(o)
  end

  def hit(o)
    if self.parent.get_achieve == true
      o.parent.set_achieve true
    end
  end
end
