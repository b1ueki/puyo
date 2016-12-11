# coding: utf-8

require 'dxruby'
require_relative 'controllable_puyo_group'
require_relative 'puyo'

Window.caption = "PuyoPuyo"
Window.width   = 640
Window.height  = 480

font = Font.new(32)
haikei = Image.load('IMG/haikei.jpg')

fell_objects = Array.new
fall_objects = ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 0]),Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 255]))


title_flg = true
Window.loop do
  title_flg = false if Input.keyPush?(K_SPACE)
  if title_flg
    Window.draw_font(100, 100, "スペースキーを押してください。", font)
  else
    Window.draw(0,0,haikei)
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
      fell_objects.push fall_objects.clone
      #fall_objects.vanish
      fall_objects = ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 0]),Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 255]))
      #puts fall_objects.get_achieve
    end

    #puts fall_objects
    #puts fell_objects[-1]
    #puts fell_objects.count
    #puts fell_objects [0]
    #puts fell_objects [1]

    Sprite.update(fall_objects)
    Sprite.update(fell_objects)
    #fall_objects.update
    #puts fall_objects.collision

    #sprite = fall_objects.check(fell_objects)
    #p sprite
    ary = Array.new
    fell_objects.each do |fo|
      ary << fo.get_puyos
    end

    p ary.flatten
    p fall_objects.get_puyos

    Sprite.check(fall_objects.get_puyos, ary.flatten)

    #Sprite.draw(fall_objects)
    fall_objects.draw
    Sprite.draw(fell_objects)
  end
end
