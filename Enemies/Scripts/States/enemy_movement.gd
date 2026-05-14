extends shooter_state

var enemy_transform
var lerp_time
var new_pos : Vector2

func Enter() -> void:
	enemy_transform = enemy as Node2D
	lerp_time = 0
	
	
func Exit() -> void: pass

@warning_ignore("unused_parameter")
func Update(delta: float) -> void: 
	move_toward_target(delta)

	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void: pass


func move_toward_target(delta_time: float):

	new_pos = lerp(start_pos, direction, lerp_time)
	lerp_time = lerp_time + delta_time * move_speed

	enemy_transform.global_position = new_pos

	
	if lerp_time >= 1:
		change_state()

func change_state():

	var machine = get_parent() as StateMachine

	if(!is_retreating):
		machine.on_child_transitioned("Shoot")
	else:
		is_retreating = false

		var parent = get_parent().get_parent() as simple_enemy
		machine.on_child_transitioned("Idle")

		parent.change_state(false)
