///@arg {String} _name - Nome do item
/// @arg {Asset.GMSprite} _spr - Sprite do item
/// @arg {Bool} _stakeable - Se o item pode ser estacavel
/// @arg {Real} _maxQtd description
function ItemStakeable(_name,_spr = beetroot_00,_stakeable = true,_maxQtd=64): ItemBase(_name,_spr) constructor {
    stakeable = _stakeable
    qtd = 1
    maxQtd = _maxQtd
}