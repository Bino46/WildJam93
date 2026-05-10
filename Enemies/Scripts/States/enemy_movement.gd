extends shooter_state

@onready var enemy = $"../.."
var enemy_transform
var lerp_time
var new_pos : Vector2

func Enter() -> void:
	enemy_transform = enemy as Node2D
	lerp_time = 0
	
func Exit() -> void: pass

@warning_ignore("unused_parameter")
func Update(delta: float) -> void: 
	print(direction.x)
	new_pos.x = lerp(start_pos.x, direction.x, lerp_time)
	lerp_time = lerp_time + delta * move_speed
	enemy_transform.position = new_pos
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void: pass
