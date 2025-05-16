var _mx = device_mouse_x_to_gui(0)
var _my = device_mouse_y_to_gui(0)

var _mxSurf = _mx-(invetorySurfProps.pos.x-invetorySurfProps.w*.5)
var _mySurf = _my-(invetorySurfProps.pos.y-invetorySurfProps.h*.5)

draw_set_font(fInventory)

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

    var _title = "Inventory"
    var _strW = string_width(_title)
var _strH = string_height(_title)
    draw_set_color(textSelectedColor)
    draw_set_align(1,1)
    draw_text(_infX+_strW*.5+4,_yy+_strH*.5,"Inventory")
    draw_reset_align()
    
    
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
    
    if navInd == 0{
        var _xx = 0
        var _yy = 0
        var _startIndex = indPage * slotsPerPage
        var _remaining = array_length(inv) - _startIndex
        var _slotsThisPage = min(slotsPerPage,_remaining)
        var _buffer = 5
        _marg = 8
        var _slotWidth = (_contentWidth - (_buffer*numSlotsW-1)-(_marg*2))/numSlotsW
        var _slotHeight = (_contentHeight*.7 - (_buffer*numSlotsH-1-(_marg*2)))/numSlotsH
        var _invW = _slotWidth*numSlotsW+_buffer*numSlotsW-1+_marg
        var _invH = _slotHeight*numSlotsH+_buffer*numSlotsH-1+_marg*.5
        var _x0 = _contentX+ _contentWidth-_invW
        var _y0 =_contentY+_contentHeight-_invH
        
        
        
        
        for(var i=0; i<_slotsThisPage; i++){
            var x1 = _x0+_xx*_slotWidth+_xx*_buffer
            var y1 = _y0 + _yy*_slotHeight+_yy*_buffer
            var x2 = x1+_slotWidth
            var y2 = y1+_slotHeight
            //draw_rectangle(x1,y1,x2,y2,false)
            
            selector.pos.toX = _x0+selector.ind.x*_slotWidth+selector.ind.x*_buffer
            selector.pos.toY = _y0 + selector.ind.y*_slotHeight+selector.ind.y*_buffer
            var sobre = point_in_rectangle(_mxSurf,_mySurf,x1,y1,x2,y2)
            if  sobre{
                if selector.ind.x != _xx || selector.ind.y != _yy{
                    //selector.ang = 30*(_xx>selector.ind.x?-1:1)
                    
                    selector.ind.x = _xx
                    selector.ind.y = _yy
                    selector.scale.x = 1.2
                    selector.scale.y = 1.2
                }
                
                if mouse_check_button_pressed(mb_left){
                    selector.scale.x = .8
                    selector.scale.y = .8
                    
                    
                    selectedSlot.x = selector.ind.x
                    selectedSlot.y = selector.ind.y
                    
                    
                    selectedSlot.page = indPage
                    
                    var _cI= _startIndex + _yy * numSlotsW + _xx
                    var _sI = selector.selectedIndex
                    //show_message($"cliecked: {_cI} || selected: {_sI}")
                    var _newSel = _cI
                    
                    if _sI != -1{
                        if inv[_sI] != -1{
                            if inv[_cI] == -1{
                                inv[_cI] = inv[_sI]
                                inv[_sI] = -1
                                _newSel = -1
                                selectedSlot.x = -1
                                selectedSlot.y = -1
                            }else{
                                if inv[_sI].id != inv[_cI].id{ //se os items o selecionado é diferente do que eu cliquei
                                    var _item = inv[_cI]
                                    inv[_cI] = inv[_sI]
                                    inv[_sI] = _item
                                    _newSel = -1
                                    selectedSlot.x = -1
                                    selectedSlot.y = -1
                                }else{ //se os items o selecionado for igual do que eu cliquei
                                    if _cI != _sI{
                                        var total = inv[_cI].qtd + inv[_sI].qtd
                                        if total < inv[_cI].maxQtd{
                                            inv[_cI].qtd = total
                                            inv[_sI] = -1
                                            _newSel = -1
                                            selectedSlot.x = -1
                                            selectedSlot.y = -1
                                        }else{
                                            var _resto = total-inv[_cI].maxQtd
                                            inv[_cI].qtd = 0
                                            inv[_sI].qtd = 0
                                            inv[_cI].qtd = inv[_cI].maxQtd
                                            inv[_sI].qtd = _resto
                                            _newSel = -1
                                            selectedSlot.x = -1
                                            selectedSlot.y = -1
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    selector.selectedIndex = _newSel
                }
            }
            
            var _isSelected = _xx == selectedSlot.x && _yy == selectedSlot.y && selectedSlot.page == indPage
            
            DrawBox(_isSelected?"w":"dt",x1,y1,_slotWidth,_slotHeight)
            
            if inv[_startIndex+i] != -1{
                var _item = inv[_startIndex+i]
                var _spr = _item.spriteIndex
                var _sprW = sprite_get_width(_spr)
                var _sprH = sprite_get_height(_spr)
                var _slotCx = x1+_slotWidth*.5
                var _slotCy = y1+_slotHeight*.5
                var drawX = _slotCx-_sprW*.5
                var drawY = _slotCy-_sprH*.5
                
                draw_sprite(_spr,0,drawX,drawY)
                
                if _item.stakeable{
                    draw_text(drawX,drawY,_item.qtd)
                }
            }
            
            _xx++
            if _xx==numSlotsW{
                _xx=0
                _yy++
            }
        }
        var _nw = numSlotsW-1
        var _nh = numSlotsH-1
        draw_set_color(textSelectedColor)
        draw_set_align(1,1)
        draw_text(_x0+_nw*_slotWidth+_nw*_buffer+_slotWidth*.5,_y0 + _nh*_slotHeight+_nh*_buffer+_slotHeight*.5,$"{indPage+1}/{numInvPages}")
        draw_reset_align()
        draw_set_color(-1)
        
        DrawSelectBox(selector.pos.x,selector.pos.y,_slotWidth,_slotHeight,selector.ang,selector.scale.x,selector.scale.y)
        
    }
   
    
    #region Button Change Page
    if indPage > 0{
        var _sW = sprite_get_width(arrow_left)
        var _sH = sprite_get_height(arrow_left)
        var _x1 = _contentX-_sW*.5
        var _y1 = _contentHeight*.5+_sH*.5
        var _x2 = _x1+_sW
        var _y2 = _y1+_sH
        draw_sprite(arrow_left,0,_x1,_y1)
        var _sobre = point_in_rectangle(_mxSurf,_mySurf,_x1,_y1,_x2,_y2)
        if _sobre{
            if mouse_check_button_pressed(mb_left) indPage--
        }
    }
    
    if indPage < numInvPages-1{
        var _sW = sprite_get_width(arrow_right)
        var _sH = sprite_get_height(arrow_right)
        var _x1 = _contentX+_contentWidth-_sW*.5
        var _y1 = _contentHeight*.5+_sH*.5
        var _x2 = _x1+_sW
        var _y2 = _y1+_sH
        draw_sprite(arrow_right,0,_x1,_y1)
        var _sobre = point_in_rectangle(_mxSurf,_mySurf,_x1,_y1,_x2,_y2)
        if _sobre{
            if mouse_check_button_pressed(mb_left) indPage++
        }
    }
    
    indPage = clamp(indPage,0,numInvPages-1)
    #endregion
    
    surface_reset_target()
}else{
    invetorySurf = surface_create(invetorySurfProps.w,invetorySurfProps.h)
}

//draw_text(30,0,$"{selectedSlot} || {selector.ind}")
draw_set_font(-1)

var mat = matrix_build(invetorySurfProps.pos.x,invetorySurfProps.pos.y,invetorySurfProps.pos.z,invetorySurfProps.angle.x,invetorySurfProps.angle.y,invetorySurfProps.angle.z,invetorySurfProps.scale.x,invetorySurfProps.scale.y,invetorySurfProps.scale.z)
////setando a matrix
matrix_set(matrix_world,mat)
draw_surface(invetorySurf,-invetorySurfProps.w*.5,-invetorySurfProps.h*.5)
matrix_set(matrix_world,matrix_build_identity())

//draw_text(30,0,$"{_mxSurf}, {_mySurf} || {selector.pos.toX}, {selector.pos.toY}")
