# coding: utf-8

require 'dxruby'
require_relative 'controllable_puyo_group'
require_relative 'puyo'

Window.caption = "PuyoPuyo"
Window.width   = 640
Window.height  = 480
timer = 0
font = Font.new(32)
font2 = Font.new(16)
haikei = Image.load('IMG/haikei.jpg')

def puyorandam
	ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,rand(4),rand(4))
end

fall_objects = puyorandam

title_flg = true
Window.loop do
  title_flg = false if Input.keyPush?(K_SPACE)
  if title_flg
    Window.draw_font(100, 100, "スペースキーを押してください。", font)
  else
    timer +=1
    timersec = (timer/60)%60
    timermin = (timer/3600)
    Window.draw(0,0,haikei)
    Window.draw_font(400,200,format("%06d",$score),font)
    Window.draw_font(400,300,format("%02d:%02d",timermin,timersec),font)
    Window.draw_box_fill($LEFT-4,$TOP,$LEFT,$BOTTOM,[255,255,255],0)
    Window.draw_box_fill($LEFT-4,$BOTTOM,$RIGHT+4,$BOTTOM+4,[255,255,255],0)
    Window.draw_box_fill($RIGHT,$TOP,$RIGHT+4,$BOTTOM+4,[255,255,255],0)
    5.times do |i|
    	Window.draw_line($LEFT+$IMG_WIDTH*(i+1),$TOP,$LEFT+$IMG_WIDTH*(i+1),$BOTTOM,C_WHITE)
    end
    11.times do |i|
    	Window.draw_line($LEFT,$TOP+$IMG_HEIGHT*(i+1),$RIGHT,$TOP+$IMG_HEIGHT*(i+1),C_WHITE)
    end

    if fall_objects.get_achieve == true

      #$fell_objects.push fall_objects.clone
      #fall_objects.vanish
      #puts fall_objects.get_achieve

      $fell_objects.push fall_objects.get_puyos
      fall_objects = puyorandam
      fall_objects.set_achieve false

      $fell_objects.flatten!

      to_vanish_objs = []
      $fell_objects.each do |obj1|
      	kouho_to_vanish_objs = []
      	$fell_objects.each do |obj2|
      	  next if obj1 == obj2
      	  next if obj1.colorindex != obj2.colorindex

      	  if (obj1.x - obj2.x).abs <= $IMG_WIDTH && obj1.y == obj2.y
      		kouho_to_vanish_objs.push obj1
      		kouho_to_vanish_objs.push obj2
      	  end
      	  if obj1.x == obj2.x && (obj1.y - obj2.y).abs <= $IMG_HEIGHT
      		kouho_to_vanish_objs.push obj1
      		kouho_to_vanish_objs.push obj2
      	  end
      	end
      	if kouho_to_vanish_objs.length >= 3
      		to_vanish_objs.concat kouho_to_vanish_objs
      	end
      end
      to_vanish_objs.uniq!
      to_vanish_objs.each do |obj|
      	obj.vanish
      	$fell_objects.delete obj
      	$score += 50
      end
    end

    #puts fall_objects
    #puts $fell_objects[-1]
    #puts $fell_objects.count
    #puts $fell_objects [0]
    #puts $fell_objects [1]

    Sprite.update(fall_objects)
    Sprite.update($fell_objects)
    #fall_objects.update
    #puts fall_objects.collision

    #sprite = fall_objects.check($fell_objects)
    #p sprite
    Sprite.check(fall_objects.get_puyos, $fell_objects)

    #Sprite.draw(fall_objects)
    fall_objects.draw
    Sprite.draw($fell_objects)
  end
end
