extends shooter_state

var shoot_timer : float
var shot : bool = false
var wait_time : float
var parent

# Shoot
@export var shoot_wait_time : float = 3
@export var wait_before_retreat : float = 2
@export var simple_shoot : bool

func Enter() -> void: 
	shoot_timer = shoot_wait_time
	wait_time = wait_before_retreat
	shot = false

	if(parent == null):
		parent = get_parent().get_parent() as simple_enemy

func Exit() -> void: pass

@warning_ignore("unused_parameter")
func Update(delta: float) -> void: 

	if(!shot):
		shoot_timer = shoot_timer - delta
	
	if(shoot_timer <= 0 && !shot):
		shoot()

	if(shot):
		wait_time -= delta

	if(wait_time <= 0):
		retreat_mode()


	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void: pass


func shoot():
	shot = true

	var pew = get_node("../../ShootScript") as shoot_script
	pew.shoot_projectile(simple_shoot)

func retreat_mode():
	is_retreating = true
	
	parent.set_direction(parent.global_position, parent.origin)

	var state = get_parent() as StateMachine
	state.on_child_transitioned("Movement")
	state.current_state.is_retreating = true
