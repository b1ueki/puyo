require_relative 'setting'

class Puyo < Sprite
  def initialize(x, y, img)
    super(x, y, img)
  end
  def update
    self.y += 1 if self.y < $BOTTOM
  end
end
