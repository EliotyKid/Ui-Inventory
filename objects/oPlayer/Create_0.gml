/// @description Insert description here
// You can write your code in this editor
hsp = 0
vsp = 0
maxHsp = 2
maxVsp = 2
acc = .3
dcc = .3



#region State Machine
LsmInit()

LsmAdd("idle",{
  step: function(){
    hsp = lerp(hsp,maxHsp*(InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT)),acc)
    vsp = lerp(vsp,maxVsp*InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP),acc)

    if hsp != 0 || vsp != 0 LsmChange("run")
  } 
})

LsmAdd("run", {
  step: function(){
    hsp = lerp(hsp,maxHsp*(InputCheck(INPUT_VERB.RIGHT) - InputCheck(INPUT_VERB.LEFT)),acc)
    vsp = lerp(vsp,maxVsp*InputCheck(INPUT_VERB.DOWN) - InputCheck(INPUT_VERB.UP),acc)
    
    if hsp == 0 || vsp == 0 LsmChange("idle")    
  }    
})

LsmAddFreeState({
  step: function(){
    if keyboard_check_released(ord("I")){
        if !instance_exists(oInventoryManager){
            instance_create_depth(0,0,-9999,oInventoryManager)
        }
    }
  }  
})
#endregion