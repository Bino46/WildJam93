class_name boss_spawn
extends Node2D

@export var enemy_obj : PackedScene

func spawn_enemy(move_to_position = Vector2.ZERO):

	var obj = enemy_obj.instantiate() as Node2D
	add_child(obj)
		
	obj.global_position = move_to_position

	var health = obj.get_node("Area2D") as boss_health
	health.reset_health()

func _on_timer_timeout() -> void:
	spawn_enemy()
