global.data = {}

with global.data {
    __itemDataBase = []
    
    ///@arg {Strucy} _item
    Add = function(_item){
        array_push(__itemDataBase,_item)
    }
    
    ///@arg {Real} _id
    ///@return {Struct,Undefined}
    FindById = function(_id){
        for(var i=0; i<array_length(__itemDataBase); i++){
            if __itemDataBase[i].id == _id{
                return {
                    pos: i,
                    item: variable_clone(__itemDataBase[i])
                }
            }
        }
        
        show_debug_message($"Item com o ID {_id} não encontrado")
        return undefined
    }
    
    ///@arg {String} _name
    ///@return {Struct,Undefined}
    FindByName = function(_name){
        for(var i=0; i<array_length(__itemDataBase); i++){
            if __itemDataBase[i].name == _name{
                return {
                    pos: i,
                    item: variable_clone(__itemDataBase[i])
                }
            }
        }
        
        show_debug_message($"Item com o nome {_id} não encontrado")
        return undefined
    }
    
    ///@desc - List all items in DataBase
    ///@return {Array} 
    List = function(){
        return variable_clone(__itemDataBase)
    }
}


#macro ITEM_DATABASE global.data
