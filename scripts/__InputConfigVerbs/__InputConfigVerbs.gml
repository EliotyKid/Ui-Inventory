function __InputConfigVerbs()
{
    enum INPUT_VERB
    {
        //Add your own verbs here!
        UP,
        DOWN,
        LEFT,
        RIGHT,
        ACCEPT,
        CANCEL,
        ACTION,
        SPECIAL,
        PAUSE,
        INVENTORY,
        SELECT,
        NAV_RIGHT,
        NAV_LEFT,
        INV_NEXT_PAGE,
        INV_PREVIOUS_PAGE,
        DIVIDE_ITEM,
        DROP_ITEM,
        TO_DROP_STACK,
        USING_ITEM
    }
    
    enum INPUT_CLUSTER
    {
        //Add your own clusters here!
        //Clusters are used for two-dimensional checkers (InputDirection() etc.)
        NAVIGATION,
    }
    
    if (not INPUT_ON_SWITCH)
    {
        InputDefineVerb(INPUT_VERB.UP,      "up",         [vk_up,    "W"],    [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",       [vk_down,  "S"],    [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",       [vk_left,  "A"],    [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",      [vk_right, "D"],    [ gp_axislh, gp_padr]);
        InputDefineVerb(INPUT_VERB.ACCEPT,  "accept",      vk_space,            gp_face1);
        InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",      vk_backspace,        gp_face2);
        InputDefineVerb(INPUT_VERB.ACTION,  "action",      vk_enter,            gp_face3);
        InputDefineVerb(INPUT_VERB.SPECIAL, "special",     vk_shift,            gp_face4);
        InputDefineVerb(INPUT_VERB.PAUSE,   "pause",       vk_escape,           gp_start);
        InputDefineVerb(INPUT_VERB.INVENTORY,   "inventory",   [ord("I"), vk_escape],            gp_select);
        InputDefineVerb(INPUT_VERB.SELECT,   "select",   [mb_left],            gp_face1);
        InputDefineVerb(INPUT_VERB.DIVIDE_ITEM,   "divide_item",   [mb_right],            gp_face2);
        InputDefineVerb(INPUT_VERB.NAV_LEFT,   "nav_left",   ord("K"),            gp_shoulderl);
        InputDefineVerb(INPUT_VERB.NAV_RIGHT,   "nav_right",   ord("L"),            gp_shoulderr);
        InputDefineVerb(INPUT_VERB.INV_NEXT_PAGE,   "inv_next_page",   ord("M"),            gp_shoulderrb);
        InputDefineVerb(INPUT_VERB.INV_PREVIOUS_PAGE,   "inv_previous_page",   ord("N"),            gp_shoulderlb);
        InputDefineVerb(INPUT_VERB.DROP_ITEM,   "drop_item",   ord("Q"),            gp_face3);
        InputDefineVerb(INPUT_VERB.TO_DROP_STACK,   "to_drop_stack",   vk_shift,            gp_stickl);
        InputDefineVerb(INPUT_VERB.USING_ITEM,   "using_item",   vk_space,            gp_face4);
    }
    else //Flip A/B over on Switch
    {
        InputDefineVerb(INPUT_VERB.UP,      "up",          undefined, [-gp_axislv, gp_padu]);
        InputDefineVerb(INPUT_VERB.DOWN,    "down",        undefined, [ gp_axislv, gp_padd]);
        InputDefineVerb(INPUT_VERB.LEFT,    "left",        undefined, [-gp_axislh, gp_padl]);
        InputDefineVerb(INPUT_VERB.RIGHT,   "right",       undefined, [ gp_axislh, gp_padr]);
        InputDefineVerb(INPUT_VERB.ACCEPT,  "accept",      undefined,   gp_face2); // !!
        InputDefineVerb(INPUT_VERB.CANCEL,  "cancel",      undefined,   gp_face1); // !!
        InputDefineVerb(INPUT_VERB.ACTION,  "action",      undefined,   gp_face3);
        InputDefineVerb(INPUT_VERB.SPECIAL, "special",     undefined,   gp_face4);
        InputDefineVerb(INPUT_VERB.PAUSE,   "pause",       undefined,   gp_start);
        InputDefineVerb(INPUT_VERB.PAUSE,   "inventory",   undefined,   gp_select);
    }
    
    //Define a cluster of verbs for moving around
    InputDefineCluster(INPUT_CLUSTER.NAVIGATION, INPUT_VERB.UP, INPUT_VERB.RIGHT, INPUT_VERB.DOWN, INPUT_VERB.LEFT);
}