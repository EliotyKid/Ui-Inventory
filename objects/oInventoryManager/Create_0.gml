global.pause = true
show = true
scl = ceil(GUI_W/240)



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
textDescColor = make_color_rgb(139,155,180)




numSlotsW = 5
numSlotsH = 3
totalSlots = 24
slotsPerPage = numSlotsW*numSlotsH-1
inv = global.playerInventory
numInvPages = ceil(totalSlots/(numSlotsW*numSlotsH))
indPage = 0


//show_message(ITEM_DATABASE.List())
selectedSlot = {
    x: -1,
    y: -1,
    page: -1
}

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
    },
    selectedIndex: -1,
}

PosToIndiceInArray = function(_xx,_yy){
    var _startIndex = indPage * slotsPerPage
    var _indice= _startIndex + _yy * numSlotsW + _xx
    return _indice
}

IndiceArrayToPos = function(_indice){
    var _localIndex = _indice - (indPage*slotsPerPage)
    if _localIndex<0 ||_localIndex>=slotsPerPage return undefined
        
    var _xx = _localIndex mod numSlotsW
    var _yy = floor(_localIndex/numSlotsW)
    return {
        x: _xx,
        y: _yy
    }
}
