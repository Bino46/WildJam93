extends Node2D

@export var _health : float = 3
var time = 0

func _process(delta: float) -> void:
	time = time + delta * 2

	var new_pos = Vector2.ZERO
	new_pos.x = cos(time) * 0.2
	new_pos.y = sin(time) * 0.2

	self.position += new_pos


func take_damage():
	print("huh")
	_health -= 1
	
	if(_health <= 0):
		var parent = get_parent() as simple_enemy
		parent.change_state(false)

func _on_area_entered(area: Area2D) -> void:
	if(area.collision_layer == 2):
		take_damage()