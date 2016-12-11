require_relative 'setting'

class Puyo < Sprite
  PUYOCOLORS = [
	Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 0]),
	Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 0, 0]),
	Image.new($IMG_WIDTH, $IMG_HEIGHT, [0, 255, 0]),
	Image.new($IMG_WIDTH, $IMG_HEIGHT, [0, 0, 255])
  ] 
  def initialize(x, y, colorindex)
    super(x, y, PUYOCOLORS[colorindex])
  	@colorindex = colorindex
  end
  def update
    self.y += 1 if self.y < $BOTTOM - $IMG_HEIGHT
  end
  def update_top
    self.y += 1 if self.y < $BOTTOM - $IMG_HEIGHT * 2
  end
end
