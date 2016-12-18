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
      @puyos[0].update
      @puyos[1].update

    puyo_movable_blocks = [[],[]]
    9.times do
      puyo_movable_blocks[0].push true
      puyo_movable_blocks[1].push true
    end
    $fell_objects.each do |obj|
      if(@puyos[0].x - $IMG_WIDTH * 2 < obj.x && obj.x < @puyos[0].x)
        if(@puyos[0].y - $IMG_HEIGHT * 2 < obj.y && obj.y < @puyos[0].y)
          puyo_movable_blocks[0][0] = false
        end
        if(@puyos[0].y - $IMG_HEIGHT < obj.y && obj.y < @puyos[0].y + $IMG_HEIGHT)
          puyo_movable_blocks[0][3] = false
        end
        if(@puyos[0].y < obj.y && obj.y < @puyos[0].y + $IMG_HEIGHT * 2)
          puyo_movable_blocks[0][6] = false
        end
      end
      if(@puyos[0].x - $IMG_WIDTH < obj.x && obj.x < @puyos[0].x + $IMG_WIDTH)
        if(@puyos[0].y - $IMG_HEIGHT * 2 < obj.y && obj.y < @puyos[0].y)
          puyo_movable_blocks[0][1] = false
        end
        if(@puyos[0].y - $IMG_HEIGHT < obj.y && obj.y < @puyos[0].y + $IMG_HEIGHT)
          puyo_movable_blocks[0][4] = false
        end
        if(@puyos[0].y < obj.y && obj.y < @puyos[0].y + $IMG_HEIGHT * 2)
          puyo_movable_blocks[0][7] = false
        end
      end
      if(@puyos[0].x < obj.x && obj.x < @puyos[0].x + $IMG_WIDTH * 2)
        if(@puyos[0].y - $IMG_HEIGHT * 2 < obj.y && obj.y < @puyos[0].y)
          puyo_movable_blocks[0][2] = false
        end
        if(@puyos[0].y - $IMG_HEIGHT < obj.y && obj.y < @puyos[0].y + $IMG_HEIGHT)
          puyo_movable_blocks[0][5] = false
        end
        if(@puyos[0].y < obj.y && obj.y < @puyos[0].y + $IMG_HEIGHT * 2)
          puyo_movable_blocks[0][8] = false
        end
      end
      if(@puyos[1].x - $IMG_WIDTH * 2 < obj.x && obj.x < @puyos[1].x)
        if(@puyos[1].y - $IMG_HEIGHT * 2 < obj.y && obj.y < @puyos[1].y)
          puyo_movable_blocks[1][0] = false
        end
        if(@puyos[1].y - $IMG_HEIGHT < obj.y && obj.y < @puyos[1].y + $IMG_HEIGHT)
          puyo_movable_blocks[1][3] = false
        end
        if(@puyos[1].y < obj.y && obj.y < @puyos[1].y + $IMG_HEIGHT * 2)
          puyo_movable_blocks[1][6] = false
        end
      end
      if(@puyos[1].x - $IMG_WIDTH < obj.x && obj.x < @puyos[1].x + $IMG_WIDTH)
        if(@puyos[1].y - $IMG_HEIGHT * 2 < obj.y && obj.y < @puyos[1].y)
          puyo_movable_blocks[1][1] = false
        end
        if(@puyos[1].y - $IMG_HEIGHT < obj.y && obj.y < @puyos[1].y + $IMG_HEIGHT)
          puyo_movable_blocks[1][4] = false
        end
        if(@puyos[1].y < obj.y && obj.y < @puyos[1].y + $IMG_HEIGHT * 2)
          puyo_movable_blocks[1][7] = false
        end
      end
      if(@puyos[1].x < obj.x && obj.x < @puyos[1].x + $IMG_WIDTH * 2)
        if(@puyos[1].y - $IMG_HEIGHT * 2 < obj.y && obj.y < @puyos[1].y)
          puyo_movable_blocks[1][2] = false
        end
        if(@puyos[1].y - $IMG_HEIGHT < obj.y && obj.y < @puyos[1].y + $IMG_HEIGHT)
          puyo_movable_blocks[1][5] = false
        end
        if(@puyos[1].y < obj.y && obj.y < @puyos[1].y + $IMG_HEIGHT * 2)
          puyo_movable_blocks[1][8] = false
        end
      end
    end

    if @puyos[0].y < $BOTTOM - $IMG_HEIGHT && @puyos[1].y < $BOTTOM - $IMG_HEIGHT && @achieve == false
      #平行移動
      if @puyos[0].y != @puyos[1].y
        if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[0].x && (puyo_movable_blocks[0][5] && puyo_movable_blocks[1][5])
          @puyos[0].x += $IMG_WIDTH
          @puyos[1].x += $IMG_WIDTH
        elsif Input.key_push?(K_LEFT) && $LEFT < @puyos[0].x && (puyo_movable_blocks[0][3] && puyo_movable_blocks[1][3])
          @puyos[0].x -= $IMG_WIDTH
          @puyos[1].x -= $IMG_WIDTH
        end
      elsif @puyos[0].x > @puyos[1].x
        if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[0].x && puyo_movable_blocks[0][5]
          @puyos[0].x += $IMG_WIDTH
          @puyos[1].x += $IMG_WIDTH
        elsif Input.key_push?(K_LEFT) && $LEFT + $IMG_WIDTH < @puyos[0].x && puyo_movable_blocks[1][3]
          @puyos[0].x -= $IMG_WIDTH
          @puyos[1].x -= $IMG_WIDTH
        end
      elsif @puyos[0].x < @puyos[1].x
        if Input.key_push?(K_RIGHT) && $RIGHT - $IMG_WIDTH > @puyos[1].x && puyo_movable_blocks[1][5]
          @puyos[0].x += $IMG_WIDTH
          @puyos[1].x += $IMG_WIDTH
        elsif Input.key_push?(K_LEFT) && $LEFT + $IMG_WIDTH < @puyos[1].x && puyo_movable_blocks[0][3]
          @puyos[0].x -= $IMG_WIDTH
          @puyos[1].x -= $IMG_WIDTH
        end
      end

      #回転
      if Input.key_push?(K_X)
        if @puyos[0].y < @puyos[1].y
          if @puyos[0].x < $RIGHT - $IMG_WIDTH * 2 && puyo_movable_blocks[0][8]
            @puyos[0].x += $IMG_WIDTH
            @puyos[0].y += $IMG_HEIGHT
          end
        elsif @puyos[0].y > @puyos[1].y
          if @puyos[0].x > $LEFT && puyo_movable_blocks[0][0]
            @puyos[0].x -= $IMG_WIDTH
            @puyos[0].y -= $IMG_HEIGHT
          end
        elsif @puyos[0].x > @puyos[1].x
          if @puyos[0].y < $BOTTOM - $IMG_HEIGHT * 2 && puyo_movable_blocks[0][6]
            @puyos[0].x -= $IMG_WIDTH
            @puyos[0].y += $IMG_HEIGHT
          end
        elsif @puyos[0].x < @puyos[1].x
          if puyo_movable_blocks[0][2]
            @puyos[0].x += $IMG_WIDTH
            @puyos[0].y -= $IMG_HEIGHT
          end
        end
      elsif Input.key_push?(K_Z)
        if @puyos[0].y < @puyos[1].y
          if @puyos[0].x != $LEFT && puyo_movable_blocks[0][6]
            @puyos[0].x -= $IMG_WIDTH
            @puyos[0].y += $IMG_HEIGHT
          end
        elsif @puyos[0].y > @puyos[1].y
          if @puyos[0].x < $RIGHT - $IMG_WIDTH * 2 && puyo_movable_blocks[0][2]
            @puyos[0].x += $IMG_WIDTH
            @puyos[0].y -= $IMG_HEIGHT
          end
        elsif @puyos[0].x > @puyos[1].x
          if puyo_movable_blocks[0][0]
            @puyos[0].x -= $IMG_WIDTH
            @puyos[0].y -= $IMG_HEIGHT
          end
        elsif @puyos[0].x < @puyos[1].x
          if @puyos[0].y < $BOTTOM - $IMG_HEIGHT * 2 && puyo_movable_blocks[0][8]
            @puyos[0].x += $IMG_WIDTH
            @puyos[0].y += $IMG_HEIGHT
          end
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
end
