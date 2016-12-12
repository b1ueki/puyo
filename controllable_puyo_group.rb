require_relative 'setting'

class ControllablePuyoGroup < Sprite
  def initialize(x, y, colorindex1, colorindex2)
    @achieve = false

    super(x, y)
    @puyos = [Puyo.new(x,y,colorindex1,self),Puyo.new(x,y + $IMG_HEIGHT,colorindex2,self)]
  end

  def get_achieve
    @achieve
  end

  def set_achieve(achieve)
    @achieve = achieve
  end

  def get_puyos
    @puyos
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

    if @puyos[0].y < $BOTTOM - $IMG_HEIGHT && @puyos[1].y < $BOTTOM - $IMG_HEIGHT && @achieve == false
      #平行移動
      if @puyos[0].y != @puyos[1].y
        @puyos[0].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[0].x
        @puyos[0].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT < @puyos[0].x
        @puyos[1].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[1].x
        @puyos[1].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT < @puyos[1].x
      elsif @puyos[0].x > @puyos[1].x
        @puyos[0].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[0].x
        @puyos[0].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT + $IMG_WIDTH < @puyos[0].x
        @puyos[1].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH * 2 > @puyos[1].x
        @puyos[1].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT < @puyos[1].x
      else
        @puyos[0].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH * 2 > @puyos[0].x
        @puyos[0].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT + $IMG_WIDTH < @puyos[0].x
        @puyos[1].x += $IMG_WIDTH if Input.key_push?(K_RIGHT) && $RIGHT > @puyos[1].x
        @puyos[1].x -= $IMG_WIDTH if Input.key_push?(K_LEFT) && $LEFT + $IMG_WIDTH < @puyos[1].x
      end

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
      #puts "#{@achieve.to_s}BOTTOMに到達"
    end
  end
  def draw
    @puyos[0].draw
    @puyos[1].draw
  end
end
