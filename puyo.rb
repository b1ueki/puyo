require_relative 'setting'

class Puyo < Sprite
  def initialize(x, y, img)
    super(x, y, img)
  end
  def update
    self.y += 1 if self.y < $BOTTOM - $IMG_HEIGHT
  end
  def update_top
    self.y += 1 if self.y < $BOTTOM - $IMG_HEIGHT * 2
  end
end
