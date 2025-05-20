// Getting the mouse position in the GUI layer
var _mx = device_mouse_x_to_gui(0)
var _my = device_mouse_y_to_gui(0)

// Converting GUI mouse position to surface-local coordinates
var _mxSurf = _mx-(invetorySurfProps.pos.x-invetorySurfProps.w*.5)
var _mySurf = _my-(invetorySurfProps.pos.y-invetorySurfProps.h*.5)


// Setting the font used for drawing inventory text
draw_set_font(fInventory)

//if the inventory surface exists
if  (surface_exists(invetorySurf))  {
  // Set the surface as the target for drawing
  surface_set_target(invetorySurf)
  // Clear the surface with transparent black
  draw_clear_alpha(c_black,0)
  
  // Padding between each container box
  var _buffeBoxes = invetorySurfProps.w*.02
  
   //==================== First Container (Left Panel) ====================//
  #region first div
  //dimension of the first div
  var _containerWidth = invetorySurfProps.w*.3 - _buffeBoxes*2
  var _containerHeight = invetorySurfProps.h - _buffeBoxes*2
  
  var _width = _containerWidth
  var _height = _containerHeight - _buffeBoxes * 2

  var _xx = _buffeBoxes
  var _yy = _buffeBoxes
  
  //== First Content (Title box with animation)
  #region first content
  var _xEnd = _xx
  var _xStart = containerInfX[0]
  var _dist = _xStart - _xEnd
  var _infX = _xStart - _dist * containerInfVal[0]
  DrawBox("lt",_infX,_yy,_width,_height*.15,inventoryScale)

  var _title = "Inventory"
  
  draw_set_color(textSelectedColor)
  draw_set_align(1,1)
  draw_text_scribble(_infX+_width*.5,_yy+(_height*.15)*.5,_title)
  draw_reset_align()
  #endregion
  
  //== Second Content (Main vertical box)
  #region second content
  _yy += _height*.15+_buffeBoxes
  _xEnd = _xx
  _xStart = containerInfX[1]
  _dist = _xStart - _xEnd
  _infX = _xStart - _dist * containerInfVal[1]
  DrawBox("w",_infX,_yy,_width,_height*.60,inventoryScale)
  #endregion
  
  //== Third Content (Bottom box)
  #region third content
  _yy += _buffeBoxes + _height*.60 
  _xEnd = _xx
  _xStart = containerInfX[2]
  _dist = _xStart - _xEnd
  _infX = _xStart - _dist * containerInfVal[2]
  DrawBox("lt",_infX,_yy,_width,_height*.25,inventoryScale)
  #endregion
  
  #endregion
  
  //==================== Second Container (Right Panel) ====================//
  #region second div
  // Dimensions of the second container
  _containerWidth = invetorySurfProps.w*.7 -  _buffeBoxes
  _containerHeight = invetorySurfProps.h - _buffeBoxes*2
  
  //== Background of the container
  #region bg
  var _containerXStart = invetorySurfProps.w*.5 - _containerWidth*.5
  var _containerXEnd = invetorySurfProps.w - _containerWidth-_buffeBoxes
  var _dist = _containerXStart - _containerXEnd
  var _containerX = _containerXStart- _dist * invA
  var _containerY = _buffeBoxes
  DrawBox("dt",_containerX,_containerY,_containerWidth,_containerHeight,inventoryScale)
  #endregion
  
  //== Drawing navbar and content background
  #region Drawing navbar
  var _marg = 2*inventoryScale
  var _indiceWidth = (_containerWidth-_marg*2)/array_length(navItems)
  var _indiceHeight = _containerHeight*.15
  var _indiceX = _containerX+_marg + navInd*_indiceWidth
  var _indiceY = _containerY+_marg
  navIndX = Approach(navIndX,_indiceX,8*inventoryScale)
  navIndX = clamp(navIndX,_containerX+_marg,_containerX+_marg + (array_length(navItems)-1)*_indiceWidth)

  
  var _contentX = _containerX+_marg
  var _contentY = _containerY+_marg+ _indiceHeight*.7
  var _contentWidth = _containerWidth-_marg*2
  var _contentHeight = _containerHeight-_indiceHeight
  DrawBox("lt",_contentX,_contentY,_contentWidth,_contentHeight,inventoryScale)
  
  
  DrawBox("lt",navIndX,_indiceY,_indiceWidth,_indiceHeight+2,inventoryScale,,,false)
  
  //== Drawing navbar buttons and handling clicks
  for  (var i=0; i<array_length(navItems); i++)  {
    var _x1 = _containerX+_marg + i * _indiceWidth
    var _y1 = _indiceY
    var _x2 = _x1+_indiceWidth
    var _y2 = _y1+_indiceHeight
    
    var _hover = point_in_rectangle(_mxSurf,_mySurf,_x1,_y1,_x2,_y2)
    if  (_hover)  {
      if  (mouse_check_button_released(mb_left))  {
        navInd = i
      }
    }
    

    draw_set_align(1,1)
    draw_set_color(i==navInd ? textSelectedColor : textUnselectedColor)
    draw_text_scribble(_x1+_indiceWidth*.5,_y1+_indiceHeight*.5-_marg,navItems[i])
    draw_set_color(-1)
    draw_reset_align()
  }
  
  if global.isGamepad{
    draw_sprite(button_lb,0,_x1,_y1)
  }
  #endregion
  
  //==================== Page 0: Inventory Slots ====================//
  #region Drawing first nav bar page
  if  (navInd == 0)  {
    #region inventory slots
    var _xx = 0
    var _yy = 0
    var _startIndex = indPage * slotsPerPage
    var _remaining = array_length(inv) - _startIndex
    var _slotsThisPage = min(slotsPerPage,_remaining)
    var _buffer = 5*inventoryScale
    _marg = 8*inventoryScale
    var _slotWidth = (_contentWidth - (_buffer*numSlotsW-1)-(_marg*2))/numSlotsW
    var _slotHeight = (_contentHeight*.7 - (_buffer*numSlotsH-1-(_marg*2)))/numSlotsH
    var _invW = _slotWidth*numSlotsW+_buffer*numSlotsW-1+_marg
    var _invH = _slotHeight*numSlotsH+_buffer*numSlotsH-1+_marg*.5
    var _x0 = _contentX+ _contentWidth-_invW
    var _y0 =_contentY+_contentHeight-_invH
    
    // Loop through each slot on the current page
    for  (var i=0; i<_slotsThisPage; i++)  {
      var x1 = _x0+_xx*_slotWidth+_xx*_buffer
      var y1 = _y0 + _yy*_slotHeight+_yy*_buffer
      var x2 = x1+_slotWidth
      var y2 = y1+_slotHeight
      
      // Update the position where the selector should move to
      selector.pos.toX = _x0+selector.ind.x*_slotWidth+selector.ind.x*_buffer
      selector.pos.toY = _y0 + selector.ind.y*_slotHeight+selector.ind.y*_buffer
      
      //== Hover and selection logic
      #region Hover and selection logic
      var _hover = point_in_rectangle(_mxSurf,_mySurf,x1,y1,x2,y2)
      if  (_hover)  {
        if  (selector.ind.x != _xx || selector.ind.y != _yy)  {
          //selector.ang = 90*(_xx>selector.ind.x?-1:1)
          selector.ind.x = _xx
          selector.ind.y = _yy
          selector.scale.x = 1.2
          selector.scale.y = 1.2
          selectedSlot.page = indPage
        }
      }
      
      //== Click logic for selecting, moving, merging or swapping items
      if  (InputPressed(INPUT_VERB.SELECT))  {
        var _resetSlot = false
        if  (selector.ind.x == _xx && selector.ind.y == _yy)  {
          var _clickedIndex= PosToIndiceInArray(_xx,_yy) 
          var _selectedIndex = selector.selectedIndex 
          var _newSel = _clickedIndex
          
          if  (_selectedIndex != -1)  { 
            if  (inv[_selectedIndex] != -1)  {
              if  (inv[_clickedIndex] == -1)  {
                // Move item to empty slot
                inv[_clickedIndex] = inv[_selectedIndex]
                inv[_selectedIndex] = -1
                _newSel = -1
                _resetSlot = true
              }  else  {
                if  (inv[_selectedIndex].id != inv[_clickedIndex].id)  { 
                  // Swap different items
                  var _item = inv[_clickedIndex]
                  inv[_clickedIndex] = inv[_selectedIndex]
                  inv[_selectedIndex] = _item
                  _newSel = -1
                  _resetSlot = true
                }  else  { 
                  // Merge same items
                  if  (_clickedIndex != _selectedIndex)  {
                    var total = inv[_clickedIndex].qtd + inv[_selectedIndex].qtd 
                    if  (total < inv[_clickedIndex].maxQtd)  {
                      // Merge all into one slot
                      inv[_clickedIndex].qtd = total
                      inv[_selectedIndex] = -1
                      _newSel = -1
                      _resetSlot = true
                    }  else  {
                      // Fill up one slot and leave the rest
                      var _resto = total-inv[_clickedIndex].maxQtd
                      inv[_clickedIndex].qtd = 0
                      inv[_selectedIndex].qtd = 0
                      inv[_clickedIndex].qtd = inv[_clickedIndex].maxQtd
                      inv[_selectedIndex].qtd = _resto 
                      if  (inv[_selectedIndex].qtd <= 0)  inv[_selectedIndex] = -1
                      _newSel = -1
                      _resetSlot = true
                    }
                  }  else  {
                    // Same slot clicked again → deselect
                    _newSel=-1
                    _resetSlot = true
                  }
                }
              }
            }
          }
          //set the position of the selected slot
          selectedSlot.x = _resetSlot ? -1 : _xx
          selectedSlot.y = _resetSlot ? -1 : _yy
          //set de new selected index
          selector.selectedIndex = _newSel
        }
        //set the page of slot selected
        selectedSlot.page = indPage
      }
        
      
      if  (InputPressed(INPUT_VERB.DIVIDE_ITEM))  {
        selector.scale.x = .8
        selector.scale.y = .8
        selectedSlot.page = indPage
          
        if  (selector.ind.x == _xx && selector.ind.y == _yy)  {
          var _cI= PosToIndiceInArray(_xx,_yy) 
          var _sI = selector.selectedIndex 
          if  (_sI != -1)  { 
            if  (inv[_sI] != -1)  {
              if  (inv[_sI].type == ITEMS_TYPE.STAKEABLE || inv[_sI].type == ITEMS_TYPE.USABLE)  {
                if  (inv[_cI] == -1)  {
                  var _item = variable_clone(inv[_sI])
                  _item.qtd = 1
                  inv[_cI] = _item
                  inv[_sI].qtd --
                  if  (inv[_sI].qtd<=0)  {
                    inv[_sI] = -1
                    selectedSlot.x = -1
                    selectedSlot.y = -1
                    selector.selectedIndex = -1
                  }
                }  else  {
                  if  (inv[_cI].id == inv[_sI].id)  {
                    if  (_cI != _sI) {
                      var _nextValue = inv[_cI].qtd + 1
                      if  (_nextValue <= inv[_cI].maxQtd)  {
                        inv[_cI].qtd ++
                        inv[_sI].qtd --
                        if  (inv[_sI].qtd<=0)  {
                          inv[_sI] = -1
                          selectedSlot.x = -1
                          selectedSlot.y = -1
                          selector.selectedIndex = -1
                        }
                      }
                    }  else  {
                      selectedSlot.x = -1
                      selectedSlot.y = -1
                      selector.selectedIndex = -1
                    }
                  } 
                }
              }
            }
          }
        }
      }
      
      #endregion
      
      var _isSelected = _xx == selectedSlot.x && _yy == selectedSlot.y && selectedSlot.page == indPage
      DrawBox(_isSelected?"w":"dt",x1,y1,_slotWidth,_slotHeight,inventoryScale)
        
      if  (inv[_startIndex+i] != -1)  {
        var _item = inv[_startIndex+i]
        var _spr = _item.spriteIndex
        var _sprW = sprite_get_width(_spr)*inventoryScale
        var _sprH = sprite_get_height(_spr)*inventoryScale
        var _slotCx = x1+_slotWidth*.5
        var _slotCy = y1+_slotHeight*.5
        var drawX = _slotCx-_sprW*.5
        var drawY = _slotCy-_sprH*.5
        
        var _textX = x1 + 3*inventoryScale
        var _textY = y1 + 3*inventoryScale
        
        draw_sprite_ext(_spr,0,drawX,drawY,inventoryScale,inventoryScale,0,c_white,1)
        
        
        switch _item.type{
          case ITEMS_TYPE.DURABILITY:
              
            break;
          case ITEMS_TYPE.STAKEABLE:
            draw_text_scribble(_textX,_textY,"[wave]"+string(_item.qtd)+"[/wave]")
            break
          case ITEMS_TYPE.USABLE:
            if _item.stakeable{
              draw_text_scribble(_textX,_textY,"[wave]"+string(_item.qtd)+"[/wave]")
            }
            break
        }
      }
      
      _xx++
      if  (_xx==numSlotsW)  {
        _xx=0
        _yy++
      }
    }
    var _nw = numSlotsW-1
    var _nh = numSlotsH-1
    draw_set_color(textSelectedColor)
    draw_set_align(1,1)
    draw_text_scribble(_x0+_nw*_slotWidth+_nw*_buffer+_slotWidth*.5,_y0 + _nh*_slotHeight+_nh*_buffer+_slotHeight*.5,$"{indPage+1}/{numInvPages}")
    draw_reset_align()
    draw_set_color(-1)
    
    #endregion
    
    #region Draw selector box
    DrawSelectBox(selector.pos.x,selector.pos.y,_slotWidth,_slotHeight,selector.ang,selector.scale.x,selector.scale.y,inventoryScale)
    #endregion
    
    #region //Using item
    if  (InputPressed(INPUT_VERB.USING_ITEM))  {
      if  (selector.selectedIndex != -1)  {
        if  (inv[selector.selectedIndex] != -1)  {
          if  (inv[selector.selectedIndex].type == ITEMS_TYPE.USABLE)  {
            script_execute(inv[selector.selectedIndex].use)
            inv[selector.selectedIndex].qtd --
            if  (inv[selector.selectedIndex].qtd <=0)  {
              inv[selector.selectedIndex] = -1
              selector.selectedIndex = -1
              selectedSlot.x = -1
              selectedSlot.y = -1
            }
          }
        }
      }
    }
    #endregion
    
    #region Button Change Page
    if  (indPage > 0)  {
      var _spr = global.isGamepad ? button_lt : arrow_left
      var _sW = sprite_get_width(_spr)*inventoryScale
      var _sH = sprite_get_height(_spr)*inventoryScale
      var _x1 = _contentX-_sW*.5
      var _y1 = _contentHeight*.5+_sH*.5
      var _x2 = _x1+_sW
      var _y2 = _y1+_sH
      draw_sprite_ext(_spr,0,_x1,_y1,inventoryScale,inventoryScale,0,c_white,1)
      var _hover = point_in_rectangle(_mxSurf,_mySurf,_x1,_y1,_x2,_y2)
      if  (_hover)  {
        if  (mouse_check_button_pressed(mb_left))  {
          indPage--
          selector.ind.x = numSlotsW-2
          selector.ind.y = numSlotsH-1
        }
      }
    }
    
    if  (indPage < numInvPages-1)  {
      var _spr = global.isGamepad ? button_rt : arrow_right
      var _sW = sprite_get_width(_spr)*inventoryScale
      var _sH = sprite_get_height(_spr)*inventoryScale
      var _x1 = _contentX+_contentWidth-_sW*.5-7
      var _y1 = _contentHeight*.5+_sH*.5
      var _x2 = _x1+_sW
      var _y2 = _y1+_sH
      draw_sprite_ext(_spr,0,_x1,_y1,inventoryScale,inventoryScale,0,c_white,1)
      var _hover = point_in_rectangle(_mxSurf,_mySurf,_x1,_y1,_x2,_y2)
      if  (_hover)  {
        if  (mouse_check_button_pressed(mb_left))  {
          indPage++
          selector.ind.x = 0
          selector.ind.y = 0
        }
      }
    }
    
    indPage = clamp(indPage,0,numInvPages-1)
    #endregion
    
    #region desenhando infos ao lado do slot

    if  (selector.selectedIndex != -1)  {
      if  (inv[selector.selectedIndex] != -1 && selectedSlot.page == indPage && selector.ind.x == selectedSlot.x && selector.ind.y == selectedSlot.y)  {
        var _x0 = _x0+selectedSlot.x*_slotWidth+selectedSlot.x*_buffer
        var _y0 = _y0 + selectedSlot.y*_slotHeight+selectedSlot.y*_buffer
        
        var _dir = selectedSlot.x >= numSlotsW-2 ? -1 : 1
        
        var _spr = _dir == 1 ? arrow_left : arrow_right
        var _sW = sprite_get_width(_spr)*inventoryScale
        var _sH = sprite_get_height(_spr)*inventoryScale
        var _xx = _x0 + (_dir == 1 ? _slotWidth-_sW*.5 : -_sW*.5)
        var _yy = _y0 + _slotHeight*.5-_sH*.5
        draw_sprite_ext(_spr,0,_xx,_yy,inventoryScale,inventoryScale,0,c_white,1)
        
        var _infoBoxW = _slotWidth*3
        var _infoBoxH = _slotHeight*1.5
        var _x1 = _xx + (_dir == 1 ? _sW*.5 :-_infoBoxW+_sW*.5)
        var _y1 = _yy - _sH*.25 - _indiceHeight*.5
        DrawBox("w",_x1,_y1,_infoBoxW,_infoBoxH,inventoryScale)
        
        var _marg = 3*inventoryScale
        var _title = inv[selector.selectedIndex].name
        var _desc = inv[selector.selectedIndex].desc
        draw_set_color(textSelectedColor)
        draw_set_align(1,1)
        draw_text_scribble(_x1+_infoBoxW*.5,_y1+_marg*2,_title)
        draw_reset_align()
        draw_set_color(textDescColor)
        draw_set_font(fDesc)
        draw_text_scribble(_x1+_marg,_y1+_marg+string_height(_title),_desc)
        draw_set_font(fInventory)
        draw_set_color(-1)
      }
    }
    
    #endregion

    #region dropando items
    if  (InputCheck(INPUT_VERB.TO_DROP_STACK))  {
      if  (InputPressed(INPUT_VERB.DROP_ITEM))  {
        if  (selector.selectedIndex != -1)  {
          if  (inv[selector.selectedIndex] != -1)  {
            instance_create_layer(oPlayer.x+30,oPlayer.y,"Instances",oDrop,{
                item: inv[selector.selectedIndex]   
            })
            
            inv[selector.selectedIndex] = -1
            selector.selectedIndex = -1
            selectedSlot.x = -1
            selectedSlot.y = -1
          }
        }
      }
    }  else  {
      if  (InputPressed(INPUT_VERB.DROP_ITEM))  {
        if  (selector.selectedIndex != -1)  {
          if  (inv[selector.selectedIndex] != -1)  {
            if  (inv[selector.selectedIndex].type == ITEMS_TYPE.STAKEABLE || inv[selector.selectedIndex].type == ITEMS_TYPE.USABLE)  {
              var _item = variable_clone(inv[selector.selectedIndex])
              _item.qtd = 1
              instance_create_layer(oPlayer.x+30,oPlayer.y,"Instances",oDrop,{
                  item: _item
              })
              inv[selector.selectedIndex].qtd --
              if  (inv[selector.selectedIndex].qtd <=0)  {
                inv[selector.selectedIndex] = -1
                selector.selectedIndex = -1
                selectedSlot.x = -1
                selectedSlot.y = -1
              }
            }  else  {
              instance_create_layer(oPlayer.x+30,oPlayer.y,"Instances",oDrop,{
                  item: inv[selector.selectedIndex]   
              })
              inv[selector.selectedIndex] = -1
              selector.selectedIndex = -1
              selectedSlot.x = -1
              selectedSlot.y = -1
            }
          }
        }
      }
    }
    #endregion
  }
  #endregion
  
  #endregion
  
  
  surface_reset_target()
}  else  {
  invetorySurf = surface_create(invetorySurfProps.w,invetorySurfProps.h)
}

draw_set_font(-1)

var mat = matrix_build(invetorySurfProps.pos.x,invetorySurfProps.pos.y,invetorySurfProps.pos.z,invetorySurfProps.angle.x,invetorySurfProps.angle.y,invetorySurfProps.angle.z,invetorySurfProps.scale.x,invetorySurfProps.scale.y,invetorySurfProps.scale.z)
////setando a matrix
matrix_set(matrix_world,mat)
draw_surface(invetorySurf,-invetorySurfProps.w*.5,-invetorySurfProps.h*.5)
matrix_set(matrix_world,matrix_build_identity())


