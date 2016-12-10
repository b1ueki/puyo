# coding: utf-8

require 'dxruby'
require_relative 'puyo'

Window.caption = "PuyoPuyo"
Window.width   = 640
Window.height  = 480

font = Font.new(32)

game_objects = Array.new
game_objects.push Puyo.new(($RIGHT - $LEFT) / 2,$TOP,Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 255]))

title_flg = true
Window.loop do
  title_flg = false if Input.keyPush?(K_SPACE)
  if title_flg
    Window.draw_font(100, 100, "スペースキーを押してください。", font)
  else
    Sprite.update(game_objects)
    Sprite.draw(game_objects)
  end
end
