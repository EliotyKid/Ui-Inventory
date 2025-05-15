global.pause = true
show = true


invetorySurf = -1
invetorySurfProps = {
    w: GUI_W*.9,
    h: GUI_H*.8,
    
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
scaleCurve = new CurveRunner(ac_inventory,"scale",1)
scaleExitCurve = new CurveRunner(ac_inventory,"scaleExit",.5)
angleCurve = new CurveRunner(ac_inventory,"angle",1)
containerCurve = new CurveRunner(ac_inventory,"containerInv",1.2)
invA = 0
valScale = 0
valAngle = 0
pos = 0

startInfoAnim = false

containerInvX = invetorySurfProps.w*.5

containerInfX = [
    invetorySurfProps.w*.5,
    invetorySurfProps.w*.5,
    invetorySurfProps.w*.5
]

containerInfVal = [
    0,
    0,
    0
]
containerInfCurve = [
    new CurveRunner(ac_inventory,"containerInfItem",.8),
    new CurveRunner(ac_inventory,"containerInfItem",1.2),
    new CurveRunner(ac_inventory,"containerInfItem",1.6)
]


navItems = ["Items", "Tools", "People"]
navInd = 0
navIndX = 0


textSelectedColor = make_color_rgb(24,20,37)
textUnselectedColor = make_color_rgb(194,133,105)



numSlotsW = 5
numSlotsH = 3
totalSlots = 24
slotsPerPage = numSlotsW*numSlotsH-1
inv = array_create(totalSlots,-1)
numInvPages = ceil(totalSlots/(numSlotsW*numSlotsH))
indPage = 0


selector = {
    pos: {
        x: GUI_W*.5,
        y: GUI_H*1.5,
        toX: GUI_W*.5,
        toY: GUI_H*1.5
    },
    ang: 0,
    ind: {
        x: 0,
        y: 0
    },
    scale: {
        x: 1,
        y: 1
    }
}