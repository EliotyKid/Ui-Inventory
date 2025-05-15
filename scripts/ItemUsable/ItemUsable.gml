///@arg {String} _name - Nome do item
///@arg {Asset.GMSprite} _spr - Sprite do item
///@arg {Function} _use - Função à ser chamada ao usar o item
///@arg {Bool} _stakeable - Se o item pode ser estacavel
function ItemUsable(_name,_spr, _use = function(){},_stakeable = true) : ItemStakeable(_name,_spr,_stakeable) constructor {
    use = _use
}