extends Node

@export var _health : float = 3
var current_health

func _ready() -> void:
	print("set boss health")
	current_health = _health

func take_damage():
	current_health -= 1
	
	if(current_health <= 0):
		var state = get_node("../StateMachine") as StateMachine
		state.on_child_transitioned("Idle")

		var parent = get_parent() as boss
		Global.add_score(parent.score_added)
		parent.change_state()

func reset_health():
	current_health = _health

func _on_area_entered(area: Area2D) -> void:
	print("ouch")
	if(area.get_collision_layer_value(2)):
		take_damage()
