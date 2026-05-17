extends Node

@export var _health : float = 3
@export var color_flash : Color
@export var color_normal : Color
var current_health
var boss_script
var boss_sprite : Sprite2D

func _ready() -> void:
	boss_script = get_parent() as boss
	current_health = _health
	boss_sprite = boss_script.get_node("Sprite2D")

func take_damage():
	current_health -= 1

	boss_sprite.modulate = color_flash
	await get_tree().create_timer(0.1).timeout
	boss_sprite.modulate = color_normal
	
	if(current_health <= 0):
		var state = get_node("../StateMachine") as StateMachine
		state.on_child_transitioned("Idle")

		var parent = get_parent() as boss
		Global.add_score(parent.score_added)
		parent.change_state()

func reset_health():
	current_health = _health

func _on_area_entered(area: Area2D) -> void:
	if(area.get_collision_layer_value(2)):
		if(!boss_script.is_protected):
			take_damage()
		else:
			boss_script.reflect_bullet(area.global_position)
