show = true


invetorySurf = -1
invetorySurfProps = {
    w: GUI_W*.8,
    h: GUI_H*.7,
    
    scale: {
        x: 0,
        y: 0,
        z: 1
    },
    
    pos: {
        x: 0,
        y: 0,
        z: 0
    },
    
    angle: {
        x: 0,
        y: 0,
        z: 0
    } 
}

invetorySurfProps.pos.x = GUI_W*.5
invetorySurfProps.pos.y = GUI_H*.5


//animation curve variables
scaleCurve = animcurve_get_channel(ac_inventory,"scale")
scaleExitCurve = animcurve_get_channel(ac_inventory,"scaleExit")
angleCurve = animcurve_get_channel(ac_inventory,"angle")
valScale = 0
valAngle = 0
pos = 0