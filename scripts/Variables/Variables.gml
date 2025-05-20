#macro GUI_W 960
#macro GUI_H 540

enum ITEMS_TYPE{
  BASE,
  DURABILITY,
  STAKEABLE,
  USABLE
}


global.pause = false


global.playerInventory = array_create(24,-1)
global.playerInventory[0]=(ITEM_DATABASE.FindById(0).item)
global.playerInventory[0].qtd = 5
global.playerInventory[3]=(ITEM_DATABASE.FindById(3).item)
global.playerInventory[5]=(ITEM_DATABASE.FindById(2).item)
global.playerInventory[6]=(ITEM_DATABASE.FindById(0).item)
global.playerInventory[17]=(ITEM_DATABASE.FindById(0).item)
global.playerInventory[6].qtd = 8

scribble_anim_wave(3,3,.08)