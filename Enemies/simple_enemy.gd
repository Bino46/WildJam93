class_name simple_enemy
extends PoolObject

func set_direction(start, direction):

	var state_machine = get_node("StateMachine") as StateMachine

	state_machine.on_child_transitioned("Movement")

	state_machine.current_state.direction = direction
	state_machine.current_state.start_pos = start
