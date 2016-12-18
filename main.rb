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
font3 = Font.new(24)
haikei = Image.load('IMG/l_244.jpg')
titleimg = Image.load('IMG/titleimage.jpg')
gameoverimg = Image.load('IMG/l_144.jpg')

def puyorandam
	ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,rand(4),rand(4))
end

fall_objects = puyorandam

title_flg = true
gameover_flg = false
Window.loop do
  title_flg = false if Input.keyPush?(K_SPACE)
  if title_flg
  	Window.drawEx(0, 0, titleimg,{scale_x:0.5,scale_y:0.6,center_x:0,center_y:0})
    Window.draw_font(150, 100, "ぷ○ぷ○風ゲームです。", font)
    Window.draw_font(200, 200, "スペースキーでスタート", font3)
  elsif gameover_flg
  	Window.drawEx(0, 0, gameoverimg,{scale_x:0.15625,scale_y:0.23,center_x:0,center_y:0})
  	Window.draw_font(200, 100, "ゲームオーバー", font)
  	Window.draw_font(200, 300, format("スコア:%6d",$score), font)
  	Window.draw_font(200, 400, "リトライ? y/n", font)
  	if Input.keyPush?(K_Y)
  	  gameover_flg = false
  	  $fell_objects.each do |obj|
      	obj.vanish
      end
  	  $fell_objects.clear
  	  fall_objects = puyorandam
  	  $score = 0
  	  timer = 0
  	elsif Input.keyPush?(K_N)
  	  break
  	end
  else
    timer +=1
    timersec = (timer/60)%60
    timermin = (timer/3600)
    Window.drawEx(0, 0, haikei,{scale_x:0.15625,scale_y:0.23,center_x:0,center_y:0})
    Window.draw_font(300,180, "スコア", font2,color:C_BLACK)
    Window.draw_font(300,200,format("%06d",$score),font,color:C_BLACK)
    Window.draw_font(300,280, "タイム", font2,color:C_BLACK)
    Window.draw_font(300,300,format("%02d:%02d",timermin,timersec),font,color:C_BLACK)
    Window.draw_box_fill($LEFT-4,$TOP,$LEFT,$BOTTOM,C_BLACK,0)
    Window.draw_box_fill($LEFT-4,$BOTTOM,$RIGHT+4,$BOTTOM+4,C_BLACK,0)
    Window.draw_box_fill($RIGHT,$TOP,$RIGHT+4,$BOTTOM+4,C_BLACK,0)
    5.times do |i|
    	Window.draw_line($LEFT+$IMG_WIDTH*(i+1),$TOP,$LEFT+$IMG_WIDTH*(i+1),$BOTTOM,C_BLACK)
    end
    11.times do |i|
    	Window.draw_line($LEFT,$TOP+$IMG_HEIGHT*(i+1),$RIGHT,$TOP+$IMG_HEIGHT*(i+1),C_BLACK)
    end

    if fall_objects.get_achieve == true

      if fall_objects.get_puyos[0].y < $TOP + $IMG_HEIGHT*2
      	#ぷよが生成される座標で止まった時
      	gameover_flg = true
      end

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
      if to_vanish_objs.length >= 1
      	#ぷよが消えた時
      	gameover_flg = false
      end
    end

    Sprite.update(fall_objects)
    Sprite.update($fell_objects)
    Sprite.check(fall_objects.get_puyos, $fell_objects)

    fall_objects.draw
    Sprite.draw($fell_objects)
  end
end
