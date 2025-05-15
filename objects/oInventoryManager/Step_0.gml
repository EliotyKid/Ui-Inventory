 var t = show ? pos < 1 : pos > 0

    if t { //só deve mudar os valores caso pos seja menor que 1
        pos += show ? delta_time/1000000 : -delta_time/500000  //incrementa a posição na curva de animação
        pos = clamp(pos,0,1) //garante que a pos fique entre 0 e 1
        valScale = animcurve_channel_evaluate(show ? scaleCurve : scaleExitCurve,pos) //valor da escala
        valAngle = animcurve_channel_evaluate(angleCurve,pos)
    }

invetorySurfProps.scale.x = valScale
invetorySurfProps.scale.y = valScale

invetorySurfProps.angle.z = 20*valAngle

if !show && invetorySurfProps.scale.x < .1 instance_destroy()

if keyboard_check_released(ord("I")) show = false


