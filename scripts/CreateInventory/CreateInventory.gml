function Inventory(_numTotalSlots) constructor{
    numTotalSlots = _numTotalSlots
    __Invetory = array_create(numTotalSlots,-1)
    
    AddItem = function(_item){
        var i=0;repeat (numTotalSlots-1) {
        	if i == -1{
                __Invetory[i] = _item
                return  true
            }
            i++
        }
        return false
    }
    
    GetInvetory = function(){
        return __Invetory
    }
}