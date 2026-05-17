class_name simple_enemy
extends PoolObject

var state_machine
var origin : Vector2
@export var score_added : float
var curr_state
var id
	
func set_direction(start, direction):

	state_machine = get_node("StateMachine") as StateMachine

	state_machine.on_child_transitioned("Movement")

	state_machine.current_state.set_direction(start, direction)


func set_origin(new_origin):
	origin = new_origin
	
