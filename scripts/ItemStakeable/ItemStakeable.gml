///@arg {String} _name - Nome do item
/// @arg {Asset.GMSprite} _spr - Sprite do item

/// @arg {Real} _maxQtd description
function ItemStakeable(_name,_spr = beetroot_00,_maxQtd=64): ItemBase(_name,_spr) constructor {
    type = ITEMS_TYPE.STAKEABLE
    stakeable = true
    qtd = 1
    maxQtd = _maxQtd
}