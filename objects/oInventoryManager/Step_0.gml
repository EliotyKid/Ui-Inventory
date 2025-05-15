

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

if !show && invetorySurfProps.scale.x < .1 instance_destroy()

if keyboard_check_released(ord("I")) show = false



