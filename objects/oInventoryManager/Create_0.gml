//setting pause to true
global.pause = true
//setting whether to show the inventory
show = true
//setting the inventory scale
inventoryScale = ceil(GUI_W/240)
//starting inventory surface
invetorySurf = -1
//setting the inventory surface properties=
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
//setting the initial position
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

//variable to control whether to animate the first div in the inventory
startInfoAnim = false

//initial position of inventory div
containerInvX = invetorySurfProps.w*.5

//initial position of first div and animation curve variables
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

//variables to controll nav bar
navItems = ["Items", "Tools", "People"]
navInd = 0
navIndX = 0

//stting colors
textSelectedColor = make_color_rgb(24,20,37)
textUnselectedColor = make_color_rgb(194,133,105)
textDescColor = make_color_rgb(139,155,180)
scribble_color_set("c_selected",make_color_rgb(24,20,37))
scribble_color_set("c_unSelected",make_color_rgb(194,133,105))


//number of slots in width / x
numSlotsW = 5
//number of slots in height / y
numSlotsH = 3
//number max of slots
totalSlots = 24
//number slots per page
slotsPerPage = numSlotsW*numSlotsH-1
//inventory to show
inv = global.playerInventory
//number of pages in inventory
numInvPages = ceil(totalSlots/(numSlotsW*numSlotsH))
//indice to controll how is the current page
indPage = 0


//selected slot properties
selectedSlot = {
  x: -1,
  y: -1,
  page: -1
}

//selector/cursor properties
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

//converts an x ​​and y position to an index in the array
PosToIndiceInArray = function(_xx,_yy)  {
    var _startIndex = indPage * slotsPerPage
    var _indice= _startIndex + _yy * numSlotsW + _xx
    return _indice
}

//converts an array position to x and y
IndiceArrayToPos = function(_indice)  {
  var _localIndex = _indice - (indPage*slotsPerPage)
  if _localIndex<0 ||_localIndex>=slotsPerPage return undefined
    
  var _xx = _localIndex mod numSlotsW
  var _yy = floor(_localIndex/numSlotsW)
  return {
    x: _xx,
    y: _yy
  }
}
