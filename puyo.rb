require_relative 'setting'

class Puyo < Sprite
  attr_accessor :parent
  def initialize(x, y, img, parent)
    super(x, y, img)
    self.parent = parent
  end
  def update
    if self.parent.get_achieve == false
      self.y += 1 if self.y < $BOTTOM - $IMG_HEIGHT
    end
  end
  def update_top
    if self.parent.get_achieve == false
      self.y += 1 if self.y < $BOTTOM - $IMG_HEIGHT * 2
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
