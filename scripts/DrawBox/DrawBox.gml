function DrawBox(_theme, _x, _y, _w, _h,_scale = 1, _top = true, _left = true, _bottom = true, _right = true)  {
  var 
    x1 = _x,
    y1 = _y,
    x2 = _x + _w,
    y2 = _y + _h,
    s = 3 * _scale; // tamanho dos tiles escalado

  // Cantos
  if  (_top && _left)
    draw_sprite_stretched(GetSlice(_theme, "tl"), 0, x1, y1, s, s);

  if  (_top && _right)
    draw_sprite_stretched(GetSlice(_theme, "tr"), 0, x2 - s, y1, s, s);

  if  (_bottom && _left)
    draw_sprite_stretched(GetSlice(_theme, "bl"), 0, x1, y2 - s, s, s);

  if  (_bottom && _right)
    draw_sprite_stretched(GetSlice(_theme, "br"), 0, x2 - s, y2 - s, s, s);

  // Bordas
  if  (_top)
    draw_sprite_stretched(GetSlice(_theme, "tc"), 0, x1 + s, y1, _w - 2 * s, s);

  if  (_left)
    draw_sprite_stretched(GetSlice(_theme, "lc"), 0, x1, y1 + s, s, _h - 2 * s);

  if  (_bottom)
    draw_sprite_stretched(GetSlice(_theme, "bc"), 0, x1 + s, y2 - s, _w - 2 * s, s);

  if  (_right)
    draw_sprite_stretched(GetSlice(_theme, "rc"), 0, x2 - s, y1 + s, s, _h - 2 * s);

  // Centro
  draw_sprite_stretched(GetSlice(_theme, "c"), 0, x1 + s, y1 + s, _w - 2 * s, _h - 2 * s);
}


function GetSlice(_theme,_name)  {
  return asset_get_index(_theme + "_box_9slice_" + _name);
}