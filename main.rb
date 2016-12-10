# coding: utf-8

require 'dxruby'
require_relative 'controllable_puyo_group'
require_relative 'puyo'

Window.caption = "PuyoPuyo"
Window.width   = 640
Window.height  = 480

game_objects = Array.new
game_objects.push ControllablePuyoGroup.new(($RIGHT - $LEFT) / 2,$TOP,Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 0]),Image.new($IMG_WIDTH, $IMG_HEIGHT, [255, 255, 255]))

Window.loop do

  Sprite.update(game_objects)
  Sprite.draw(game_objects)

end
