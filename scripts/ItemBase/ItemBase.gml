///@arg {String} _name - Nome do item
/// @arg {Asset.GMSprite} _spr - Sprite do item
///@arg {String} _desc - Descrição do item
function ItemBase(_name,_spr = beetroot_00,_desc = "") constructor {
    type = ITEMS_TYPE.BASE
    id = GetNextId()
    name = _name
    spriteIndex = _spr
    desc = _desc
}