/// @description Insert description here
// You can write your code in this editor
hsp = 0
vsp = 0
maxHsp = 2
maxVsp = 2
acc = .3
dcc = .3


checkColisionWithDrop = function(){
  var list = ds_list_create();
  var _num = instance_place_list(x, y, oDrop, list, true);
  

  if (_num > 0) {
    for (var i = 0; i < _num; i++) {
      var _drop = list[| i];
    

      if (place_meeting(x, y, _drop)) {
        takeItem(_drop)
      }
    }
  }

  ds_list_destroy(list);
}

takeItem = function(_drop) {
  var _coletado = false;
  var _numSlots = array_length(global.playerInventory);
  var _item = _drop.item; // Struct do item dropado
  // Primeiro tenta empilhar com item já existente
  if _item.type == ITEMS_TYPE.STAKEABLE || _item.type == ITEMS_TYPE.USABLE{
    if _item.stakeable == true{
      for (var j = 0; j < _numSlots; j++) {
        var _inv = global.playerInventory[j];

        if (_inv != -1 && _inv.id == _item.id) {
          var total = _inv.qtd + _item.qtd;

          if (total <= _inv.maxQtd) {
            _inv.qtd = total;
            _coletado = true;
            instance_destroy(_drop);
            break;
          } else {
            var _resto = total - _inv.maxQtd;
            _inv.qtd = _inv.maxQtd;
            _item.qtd = _resto; // Atualiza o drop com o restante
            break
          }
        }
      }
    }
  }
  
  // Se ainda restou algo, tenta colocar em slot vazio
  if (!_coletado) {
    for (var j = 0; j < _numSlots; j++) {
      if _item.type == ITEMS_TYPE.STAKEABLE || _item.type == ITEMS_TYPE.USABLE{
        if _item.qtd > 0{
          if (global.playerInventory[j] == -1) {
            global.playerInventory[j] = _item
            _coletado = true;
            instance_destroy(_drop)
            break;
          }
        }else{
          instance_destroy(_drop)
        }
      }else{
        if (global.playerInventory[j] == -1) {
          global.playerInventory[j] = _item
          _coletado = true;
          instance_destroy(_drop)
          break;
        }
      }
    }
  }
}


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
    if InputPressed(INPUT_VERB.INVENTORY){
      if !instance_exists(oInventoryManager){
        instance_create_depth(0,0,-9999,oInventoryManager)
      }
    }
  } 
})
#endregion