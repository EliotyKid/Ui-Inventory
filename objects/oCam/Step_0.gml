if  (!instance_exists(target))  exit

var _camToX = target.x - camW * .5
var _camToY = target.y - camH * .6

camX = lerp(camX,_camToX,spd)
camY = lerp(camY,_camToY,spd)
camera_set_view_pos(view,camX,camY)