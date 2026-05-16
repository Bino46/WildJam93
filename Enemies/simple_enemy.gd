class_name simple_enemy
extends PoolObject

var state_machine
var origin : Vector2
@export var color_at_state : Array[Color]
@export var score_added : float
var curr_state
var id
	
func set_direction(start, direction):

	state_machine = get_node("StateMachine") as StateMachine

	state_machine.on_child_transitioned("Movement")

	state_machine.current_state.set_direction(start, direction)


func set_origin(new_origin):
	origin = new_origin


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	change_color(state_machine.current_state)


func change_color(state):

	if(curr_state != str(state).get_slice(":", 0)):

		curr_state = str(state).get_slice(":", 0)

		match(curr_state):
			"Movement":
				id = 0
			"Shoot":
				id = 1 
			"Idle":
				id = 3
				
		self.modulate = color_at_state[id]
		

func change_color_id(new_id):
		
	self.modulate = color_at_state[new_id]
