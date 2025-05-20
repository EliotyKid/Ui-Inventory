///@arg {String} _name - Nome do item
///@arg {Asset.GMSprite} _spr - Sprite do item
///@arg {String} _desc - Descrição do item
///@arg {Real} _max_durability - valor maximo de durabilidade
function ItemDurability(_name,_spr,_desc,_max_durability = 10) : ItemBase(_name,_spr,_desc) constructor  {
  type = ITEMS_TYPE.DURABILITY
  maxDurability = _max_durability
  durability = maxDurability
}