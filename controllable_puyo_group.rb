require_relative 'setting'

class ControllablePuyoGroup < Sprite
  def initialize(x, y, img1, img2)
    @achieve = false
    super(x, y, img1)
    @puyos = [Puyo.new(x,y,img1),Puyo.new(x,y + $IMG_HEIGHT,img2)]
  end
  def get_achieve
    @achieve
  end
  def set_achieve(achieve)
    @achieve = achieve
  end
  def update
    #落下
      if @puyos[0].y < @puyos[1].y
        @puyos[0].update_top
        @puyos[1].update
      elsif @puyos[0].y > @puyos[1].y
        @puyos[0].update
        @puyos[1].update_top
      else
        @puyos[0].update
        @puyos[1].update
      end

    if @puyos[0].y < $BOTTOM - $IMG_HEIGHT && @puyos[1].y < $BOTTOM - $IMG_HEIGHT
      #平行移動
      @puyos[0].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[0].x
      @puyos[0].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT < @puyos[0].x
      @puyos[1].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[1].x
      @puyos[1].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT < @puyos[1].x

     #回転
     if Input.key_push?(K_X)
       if @puyos[0].y < @puyos[1].y
         if @puyos[0].x == $RIGHT - $IMG_WIDTH
           @puyos[0].y += $IMG_HEIGHT
           @puyos[1].x -= $IMG_WIDTH
         else
          @puyos[0].x += $IMG_WIDTH
          @puyos[0].y += $IMG_HEIGHT
        end
       elsif @puyos[0].y > @puyos[1].y
         @puyos[0].x -= $IMG_WIDTH
         @puyos[0].y -= $IMG_HEIGHT
       elsif @puyos[0].x > @puyos[1].x
         @puyos[0].x -= $IMG_WIDTH
         @puyos[0].y += $IMG_HEIGHT
       else
         @puyos[0].x += $IMG_WIDTH
         @puyos[0].y -= $IMG_HEIGHT
       end
     elsif Input.key_push?(K_Z)
       if @puyos[0].y < @puyos[1].y
         if @puyos[0].x == $LEFT
           @puyos[0].y += $IMG_HEIGHT
           @puyos[1].x += $IMG_WIDTH
         else
           @puyos[0].x -= $IMG_WIDTH
           @puyos[0].y += $IMG_HEIGHT
         end
       elsif @puyos[0].y > @puyos[1].y
         @puyos[0].x += $IMG_WIDTH
         @puyos[0].y -= $IMG_HEIGHT
       elsif @puyos[0].x > @puyos[1].x
         @puyos[0].x -= $IMG_WIDTH
         @puyos[0].y -= $IMG_HEIGHT
       else
         @puyos[0].x += $IMG_WIDTH
         @puyos[0].y += $IMG_HEIGHT
       end
     end
    else
      @achieve = true
    end
  end
  def draw
    @puyos[0].draw
    @puyos[1].draw
  end
  def shot(obj)
    @achieve = true
    puts "shot"
  end
  def hit(obj)
    puts "hit"
  end
end
