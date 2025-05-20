//By @Elioty

function __add_sub_state(_name,_stru,_sub_state){
  if  (variable_struct_exists(_stru,_sub_state))  {
    self[$ string(_name)+"_"+_sub_state] = _stru[$ _sub_state]
  }
}

function __sub_state_execute(_state)  {
  if  (!is_undefined(self[$ current_state+"_"+_state]))  script_execute(self[$ current_state+"_"+_state])
}

///@desc initializes the variables for the state machine
///@arg {String} _init_state the initial state
function LsmInit(_init_state = "idle")  {
  self[$ "states"] = []
  self[$ "current_state"] = _init_state
  self[$ "enter_state"] = false
  self[$ "free_state_enable"] = false
}

///@desc updates the state every frame
function LsmUpdate()  {
  if  (free_state_enable)  {
    if !is_undefined(self[$ "free_state_step_begin"]) script_execute(self[$ "free_state_step_begin"])
    if !is_undefined(self[$ "free_state_step"]) script_execute(self[$ "free_state_step"])
    if !is_undefined(self[$ "free_state_step_end"]) script_execute(self[$ "free_state_step_end"])
  }
  
  if  (enter_state == false)  {
    __sub_state_execute("enter")
    enter_state = true
  }
  
  
  if  (current_state != noone)  {
    __sub_state_execute("begin_step")
    __sub_state_execute("step")
    __sub_state_execute("end_step")
  }
}

///@desc draw the design of each state
function LsmDraw()  {
  if  (!is_undefined(self[$ "free_state_draw"]))  script_execute(self[$ "free_state_draw"])
  __sub_state_execute("draw")
}

///@desc draw the drawn gui of each state
function LsmDrawGui()  {
  if  (!is_undefined(self[$ "free_state_draw_gui"]))  script_execute(self[$  "free_state_draw_gui"])
  __sub_state_execute("draw_gui")
}



///@desc add a new state
/// @arg {String} _name the name of the state
/// @arg {Struct} _stru the structure with the sub states
function LsmAdd(_name, _stru = {}){
  array_push(states,_name)
  
  __add_sub_state(_name,_stru,"step")
  
  __add_sub_state(_name,_stru,"enter")
  
  __add_sub_state(_name,_stru,"begin_step")
  
  __add_sub_state(_name,_stru,"end_step")
  
  __add_sub_state(_name,_stru,"draw")
  
  __add_sub_state(_name,_stru,"draw_gui")
  
  __add_sub_state(_name,_stru,"leave")
}

///@desc change state
///@arg {String} _name name of the destination state
function LsmChange(_name){
  if !is_undefined(self[$ current_state+"_leave"]) script_execute(self[$ current_state+"_leave"])
  current_state = _name
  enter_state = false
}

///@desc adds a state that will run all the time
function LsmAddFreeState(_stru={ }){
  var _name = "free_state"
  free_state_enable = true
  
  __add_sub_state(_name,_stru,"step")
      
  __add_sub_state(_name,_stru,"begin_step")
  
  __add_sub_state(_name,_stru,"end_step")
  
  __add_sub_state(_name,_stru,"draw")
  
  __add_sub_state(_name,_stru,"draw_gui")
  
  __add_sub_state(_name,_stru,"leave")
}


