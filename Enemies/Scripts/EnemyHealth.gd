extends PoolObject

@export var _health = 3
var time = 0

func _process(delta: float) -> void:
	time = time + delta * 2

	var new_pos = Vector2.ZERO
	new_pos.x = cos(time) * 0.2
	new_pos.y = sin(time) * 0.2

	self.position += new_pos

func take_damage():
	_health -= 1
	
	if(_health <= 0):
		change_state(false)
