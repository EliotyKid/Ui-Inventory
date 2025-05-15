///@arg {String} _name - Nome do item
/// @arg {Asset.GMSprite} _spr - Sprite do item
function ItemBase(_name,_spr = beetroot_00) constructor {
    id = GetNextId()
    name = _name
    spriteIndex = _spr
}