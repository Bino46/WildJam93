extends shooter_state

var shoot_timer : float
var shot : bool = false
var wait_time : float

func Enter() -> void: 
	shoot_timer = shoot_wait_time
	wait_time = wait_before_retreat

func Exit() -> void: pass

@warning_ignore("unused_parameter")
func Update(delta: float) -> void: 

	if(!shot):
		print("wait shoot")
		shoot_timer = shoot_timer - delta
	
	if(shoot_timer <= 1):
		shoot()

	if(shot):
		print("wait retreat")
		wait_time -= delta

	if(wait_time <= 0):
		retreat_mode()


	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void: pass


func shoot():
	shot = true
	print("shoot")
	# do smth

func retreat_mode():
	print("retreat")
	is_retreating = true
	var parent = get_parent() as StateMachine

	var enemy_transform = enemy as Node2D
	parent.set_direction(self.position, enemy_transform.position)

	parent.on_child_transitioned("Movement")
