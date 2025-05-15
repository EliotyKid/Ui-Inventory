if surface_exists(invetorySurf){
    surface_set_target(invetorySurf)
    draw_clear_alpha(c_black,0)
    var _buffeBoxes = invetorySurfProps.w*.02
    
    
    
    //First peace
    var _containerWidth = invetorySurfProps.w*.3 - _buffeBoxes*2
    var _containerHeight = invetorySurfProps.h - _buffeBoxes*2
    
    var _width = _containerWidth
    var _height = _containerHeight - _buffeBoxes * 2

    var _xx = _buffeBoxes
    var _yy = _buffeBoxes

    DrawBox("dt",_xx,_yy,_width,_height*.15)
    _yy += _height*.15+_buffeBoxes

    DrawBox("w",_xx,_yy,_width,_height*.60)
    _yy += _buffeBoxes + _height*.60 

    DrawBox("lt",_xx,_yy,_width,_height*.25)
    
    //Second Peace
    _containerWidth = invetorySurfProps.w*.7 -  _buffeBoxes
    _containerHeight = invetorySurfProps.h - _buffeBoxes*2
    
    var _containerX = invetorySurfProps.w - _containerWidth-_buffeBoxes
    var _containerY = _buffeBoxes
    
    
    DrawBox("dt",_containerX,_containerY,_containerWidth,_containerHeight)
    
    
    var _buffer = 2
    
    var _indiceWidth = (_containerWidth-_buffer*2)/3
    var _indiceHeight = _containerHeight*.15
    var _indiceX = _containerX+_buffer
    var _indiceY = _containerY+_buffer
    
    var _contentX = _containerX+_buffer
    var _contentY = _containerY+_buffer+ _indiceHeight*.7
    var _contentWidth = _containerWidth-_buffer*2
    var _contentHeight = _containerHeight-_indiceHeight
    DrawBox("lt",_contentX,_contentY,_contentWidth,_contentHeight)
    
    DrawBox("lt",_indiceX,_indiceY,_indiceWidth,_indiceHeight+1,,,false)
    
    surface_reset_target()
}else{
    invetorySurf = surface_create(invetorySurfProps.w,invetorySurfProps.h)
}

var mat = matrix_build(invetorySurfProps.pos.x,invetorySurfProps.pos.y,invetorySurfProps.pos.z,invetorySurfProps.angle.x,invetorySurfProps.angle.y,invetorySurfProps.angle.z,invetorySurfProps.scale.x,invetorySurfProps.scale.y,invetorySurfProps.scale.z)
////setando a matrix
matrix_set(matrix_world,mat)
draw_surface(invetorySurf,-invetorySurfProps.w*.5,-invetorySurfProps.h*.5)
matrix_set(matrix_world,matrix_build_identity())