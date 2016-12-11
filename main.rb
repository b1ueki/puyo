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

fell_objects = Array.new
fall_objects = ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 0]),Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 255]))


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
      fell_objects.push fall_objects
      fall_objects = ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 0]),Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 255]))
      fall_objects.set_achieve false
    end
    
    #puts fall_objects.count
    puts fell_objects.count

    Sprite.check(fall_objects, fell_objects, :shot, :hit)
    Sprite.update(fall_objects)
    Sprite.draw(fall_objects)
    Sprite.draw(fell_objects)
  end
end
