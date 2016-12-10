require_relative 'setting'

class ControllablePuyoGroup < Sprite
  def initialize(x, y, img1, img2)
    super(x, y, img1)
    @puyos = [Puyo.new(x,y,img1),Puyo.new(x,y + $IMG_HEIGHT,img2)]
  end
  def update
    @puyos[0].update
    @puyos[1].update
    @puyos[0].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH >= @puyos[0].x
    @puyos[0].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT < @puyos[0].x
    @puyos[1].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH >= @puyos[1].x
    @puyos[1].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT < @puyos[1].x
  end
  def draw
    @puyos[0].draw
    @puyos[1].draw
  end
end
