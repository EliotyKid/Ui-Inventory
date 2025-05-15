var _mx = device_mouse_x_to_gui(0)
var _my = device_mouse_y_to_gui(0)

var _mxSurf = _mx-(invetorySurfProps.pos.x-invetorySurfProps.w*.5)
var _mySurf = _my-(invetorySurfProps.pos.y-invetorySurfProps.h*.5)

draw_set_font(fInventory)
//var x1 = (invetorySurfProps.pos.x-invetorySurfProps.w*.5)
//var y1 = (invetorySurfProps.pos.y-invetorySurfProps.h*.5)
//var x2 = (invetorySurfProps.pos.x-invetorySurfProps.w*.5)+invetorySurfProps.w
//var y2 = (invetorySurfProps.pos.y-invetorySurfProps.h*.5)+invetorySurfProps.h
//draw_rectangle(x1,y1,x2,y2,false)

//draw_text(30,0,$"{_mxSurf}, {_mySurf}")
//var s = point_in_rectangle(_mxSurf,_mySurf,0,0,invetorySurfProps.w,invetorySurfProps.h)
//if s show_message(45)
//if point_in_rectangle(_mxSurf,_mySurf,,,,) show_message("dentro")

if surface_exists(invetorySurf){
    surface_set_target(invetorySurf)
    draw_clear_alpha(c_black,0)
    var _buffeBoxes = invetorySurfProps.w*.02
    
    #region first div
    //Infos?
    var _containerWidth = invetorySurfProps.w*.3 - _buffeBoxes*2
    var _containerHeight = invetorySurfProps.h - _buffeBoxes*2
    
    var _width = _containerWidth
    var _height = _containerHeight - _buffeBoxes * 2

    var _xx = _buffeBoxes
    var _yy = _buffeBoxes
    
    //first
    var _xEnd = _xx
    var _xStart = containerInfX[0]
    var _dist = _xStart - _xEnd
    var _infX = _xStart - _dist * containerInfVal[0]
    DrawBox("dt",_infX,_yy,_width,_height*.15)
    //DrawBox("w",_infX-4,_yy+4,24,16)
    //draw_sprite_ext(crate_base,0,_infX,_yy,.8,.8,0,c_white,1)
    //draw_sprite_ext(kale_05,0,_infX+1,_yy-3,.8,.8,0,c_white,1)
    
    
    
    
    _yy += _height*.15+_buffeBoxes
    _xEnd = _xx
    _xStart = containerInfX[1]
    _dist = _xStart - _xEnd
    _infX = _xStart - _dist * containerInfVal[1]
    DrawBox("w",_infX,_yy,_width,_height*.60)
    _yy += _buffeBoxes + _height*.60 

    _xEnd = _xx
    _xStart = containerInfX[2]
    _dist = _xStart - _xEnd
    _infX = _xStart - _dist * containerInfVal[2]
    DrawBox("lt",_infX,_yy,_width,_height*.25)
    #endregion
    
    #region second div
    //Second Peace
    _containerWidth = invetorySurfProps.w*.7 -  _buffeBoxes
    _containerHeight = invetorySurfProps.h - _buffeBoxes*2
    
    #region bg
    var _containerXStart = invetorySurfProps.w*.5 - _containerWidth*.5
    var _containerXEnd = invetorySurfProps.w - _containerWidth-_buffeBoxes
    var _dist = _containerXStart - _containerXEnd
    var _containerX = _containerXStart- _dist * invA
    var _containerY = _buffeBoxes
    DrawBox("dt",_containerX,_containerY,_containerWidth,_containerHeight)
    #endregion
    
    var _marg = 2
    var _indiceWidth = (_containerWidth-_marg*2)/array_length(navItems)
    var _indiceHeight = _containerHeight*.15
    var _indiceX = _containerX+_marg + navInd*_indiceWidth
    var _indiceY = _containerY+_marg
    navIndX = Approach(navIndX,_indiceX,8)

    
    var _contentX = _containerX+_marg
    var _contentY = _containerY+_marg+ _indiceHeight*.7
    var _contentWidth = _containerWidth-_marg*2
    var _contentHeight = _containerHeight-_indiceHeight
    DrawBox("lt",_contentX,_contentY,_contentWidth,_contentHeight)
    
    DrawBox("lt",navIndX,_indiceY,_indiceWidth,_indiceHeight+1,,,,false)
    
    
    
    for(var i=0; i<array_length(navItems); i++){
        var _x1 = _containerX+_marg + i * _indiceWidth
        var _y1 = _indiceY
        var _x2 = _x1+_indiceWidth
        var _y2 = _y1+_indiceHeight
        
        //draw_rectangle(_x1,_y1,_x2,_y2,false)
        var _sobre = point_in_rectangle(_mxSurf,_mySurf,_x1,_y1,_x2,_y2)
        if _sobre{
            if mouse_check_button_released(mb_left){
                navInd = i
            }
        }
        
        
        draw_set_align(1,1)
        draw_set_color(i==navInd ? textSelectedColor : textUnselectedColor)
        draw_text(_x1+_indiceWidth*.5,_y1+_indiceHeight*.5-_marg,navItems[i])
        draw_set_color(-1)
        draw_reset_align()
    }
    
    
    #region Button Change Page
    
    
    
    #endregion
    
    surface_reset_target()
}else{
    invetorySurf = surface_create(invetorySurfProps.w,invetorySurfProps.h)
}

draw_set_font(-1)

var mat = matrix_build(invetorySurfProps.pos.x,invetorySurfProps.pos.y,invetorySurfProps.pos.z,invetorySurfProps.angle.x,invetorySurfProps.angle.y,invetorySurfProps.angle.z,invetorySurfProps.scale.x,invetorySurfProps.scale.y,invetorySurfProps.scale.z)
////setando a matrix
matrix_set(matrix_world,mat)
draw_surface(invetorySurf,-invetorySurfProps.w*.5,-invetorySurfProps.h*.5)
matrix_set(matrix_world,matrix_build_identity())