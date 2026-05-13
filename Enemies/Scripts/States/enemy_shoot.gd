extends shooter_state

var shoot_timer : float
var shot : bool = false
var wait_time : float

func Enter() -> void: 
	shoot_timer = shoot_wait_time
	wait_time = wait_before_retreat
	shot = false

func Exit() -> void: pass

@warning_ignore("unused_parameter")
func Update(delta: float) -> void: 

	if(!shot):
		shoot_timer = shoot_timer - delta
	
	if(shoot_timer <= 1 && !shot):
		shoot()

	if(shot):
		wait_time -= delta

	if(wait_time <= 0):
		retreat_mode()


	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void: pass


func shoot():
	shot = true
	# do smth

func retreat_mode():
	is_retreating = true

	var parent = get_parent().get_parent() as simple_enemy
	parent.set_direction(parent.global_position, parent.origin)

	var state = get_parent() as StateMachine
	state.on_child_transitioned("Movement")
	state.current_state.is_retreating = true
