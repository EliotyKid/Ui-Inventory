///@arg {String} _name - Nome do item
///@arg {Asset.GMSprite} _spr - Sprite do item
///@arg {String} _desc - Descrição do item
///@arg {Function} _use - Função à ser chamada ao usar o item
///@arg {Bool} _stakeable - Se o item pode ser estacavel
///@arg {Real} _maxQtd
function ItemUsable(_name,_spr,_desc, _use = function(){},_stakeable = true,_maxQtd = 64) : ItemStakeable(_name,_spr,_desc,_maxQtd) constructor  {
  type = ITEMS_TYPE.USABLE
  stakeable = _stakeable
  use = _use
}