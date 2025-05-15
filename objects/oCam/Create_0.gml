target = instance_exists(oPlayer) ? oPlayer : -1
view = view_camera[0]
camW  = 384
camH = 216

spd = .1

camera_set_view_size(view,camW,camH)

if !instance_exists(target) exit
    
camX = target.x - camW * .5
camY = target.y - camH * .6
camera_set_view_pos(view,camX,camY)
