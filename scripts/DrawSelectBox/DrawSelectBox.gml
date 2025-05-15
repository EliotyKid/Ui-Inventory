function DrawSelectBox(_x, _y, _w, _h, _angle=0, _scaleX=1, _scaleY=1) {
    var surf_w = _w+8;
    var surf_h = _h+8;

    // Criar surface temporária
    var surf = -1;
    if (!surface_exists(surf)) {
        surf = surface_create(surf_w, surf_h);
    }

    // Salva surface alvo atual e define a surface temporária como destino
    surface_set_target(surf);
    draw_clear_alpha(c_white, 0); // limpa com transparência

    // Desenha os cantos na surface, sem rotação/escala
    draw_sprite(selectbox_tl, 0, 2, 2);
    draw_sprite(selectbox_bl, 0, 2, surf_h - 6-4);
    draw_sprite(selectbox_br, 0, surf_w - 6-4, surf_h - 6-4);
    draw_sprite(selectbox_tr, 0, surf_w - 6-4, 2);

    // Volta para a surface anterior
    surface_reset_target();
    //// Salva a matriz atual
    var old_matrix = matrix_get(matrix_world);
    //// Cria matriz para posicionar, rotacionar e escalar a surface
    var mat = matrix_build(_x+_w*.5, _y+_h*.5, 0, 0, 0, _angle, _scaleX, _scaleY, 0);
    matrix_set(matrix_world, mat);
    //// Desenha a surface com origem no topo esquerdo (0,0) da transformação
    draw_surface(surf, -surf_w*.5, -surf_h*.5);
    //// Restaura a matriz original
    matrix_set(matrix_world, old_matrix);
    //// Libera a surface (opcional, caso não queira reaproveitar)
    surface_free(surf);
}
