class_name EnemyHealth
extends Node2D

@export var _health : float = 3
var current_health

func _ready() -> void:
	current_health = _health

func take_damage():
	current_health -= 1
	
	if(current_health <= 0):
		var state = get_node("../StateMachine") as StateMachine
		state.on_child_transitioned("Idle")

		var parent = get_parent() as simple_enemy
		Global.add_score(parent.score_added)
		parent.change_state(false)

func reset_health():
	current_health = _health

func _on_area_entered(area: Area2D) -> void:
	if(area.get_collision_layer_value(2)):
		take_damage()
