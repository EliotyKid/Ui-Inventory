//animating the first div
if  (startInfoAnim)  {
  invA = containerCurve.getValue()
  containerInfVal[0] = containerInfCurve[0].getValue()
  containerInfVal[1] = containerInfCurve[1].getValue()
  containerInfVal[2] = containerInfCurve[2].getValue()
}

//animating the inventory div
valScale = show?scaleCurve.getValue():scaleExitCurve.getValue()
valAngle = angleCurve.getValue()

startInfoAnim = scaleCurve.pos >= .5


invetorySurfProps.scale.x = valScale
invetorySurfProps.scale.y = valScale

invetorySurfProps.angle.z = 20*valAngle

//if not to show the inventory
if  (!show) {
  if invetorySurfProps.scale.x < .1 instance_destroy()
  global.playerInventory = inv
  global.pause = false
}

//setting show to false
if  (InputPressed(INPUT_VERB.INVENTORY)) show = false

//animating the selector
selector.pos.x = lerp(selector.pos.x, selector.pos.toX,.25)
selector.pos.y = lerp(selector.pos.y, selector.pos.toY,.25)
selector.scale.x = lerp(selector.scale.x, 1,.1)
selector.scale.y = lerp(selector.scale.y, 1,.1)
selector.ang = lerp(selector.ang,0,.1)

//moving the selctor
selector.ind.x += InputPressed(INPUT_VERB.RIGHT)-InputPressed(INPUT_VERB.LEFT)
selector.ind.x = clamp(selector.ind.x,0,numSlotsW-1)

selector.ind.y += InputPressed(INPUT_VERB.DOWN)-InputPressed(INPUT_VERB.UP)
selector.ind.y = clamp(selector.ind.y,0,numSlotsH-1)

//changing nav bar index
navInd += InputPressed(INPUT_VERB.NAV_RIGHT)-InputPressed(INPUT_VERB.NAV_LEFT)
navInd = clamp(navInd,0,array_length(navItems)-1)

//changing pages in inventory
if  (navInd == 0)  {
  indPage += InputPressed(INPUT_VERB.INV_NEXT_PAGE)-InputPressed(INPUT_VERB.INV_PREVIOUS_PAGE)
  indPage = clamp(indPage,0,numInvPages-1)
}






