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
game_objects = Array.new
game_objects.push ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 0]),Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 255]))

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
    Sprite.update(game_objects)
    Sprite.draw(game_objects)
  end
end
