

if startInfoAnim{
    invA = containerCurve.getValue()
    containerInfVal[0] = containerInfCurve[0].getValue()
    containerInfVal[1] = containerInfCurve[1].getValue()
    containerInfVal[2] = containerInfCurve[2].getValue()
}

valScale = show?scaleCurve.getValue():scaleExitCurve.getValue()
valAngle = angleCurve.getValue()

startInfoAnim = scaleCurve.pos >= .5


invetorySurfProps.scale.x = valScale
invetorySurfProps.scale.y = valScale

invetorySurfProps.angle.z = 20*valAngle

if !show {
    if invetorySurfProps.scale.x < .1 instance_destroy()
    global.pause = false
}


if keyboard_check_released(ord("I")) show = false


selector.pos.x = lerp(selector.pos.x, selector.pos.toX,.25)
selector.pos.y = lerp(selector.pos.y, selector.pos.toY,.25)
selector.scale.x = lerp(selector.scale.x, 1,.1)
selector.scale.y = lerp(selector.scale.y, 1,.1)
selector.ang = lerp(selector.ang,0,.1)


selector.ind.x += keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)
selector.ind.x = clamp(selector.ind.x,0,numSlotsW-1)

selector.ind.y += keyboard_check_pressed(vk_down)-keyboard_check_pressed(vk_up)
selector.ind.y = clamp(selector.ind.y,0,numSlotsH-1)


