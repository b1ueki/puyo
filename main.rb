# coding: utf-8

require 'dxruby'
require_relative 'puyo'

Window.caption = "PuyoPuyo"
Window.width   = 640
Window.height  = 480

game_objects = Array.new
game_objects.push Puyo.new(($RIGHT - $LEFT) / 2,$TOP,Image.new(30, 30, [255, 255, 255]))

Window.loop do

  Sprite.update(game_objects)
  Sprite.draw(game_objects)

end
