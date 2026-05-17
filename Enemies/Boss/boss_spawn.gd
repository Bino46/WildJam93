class_name boss_spawn
extends Node2D

@export var enemy_obj : PackedScene
@export var fin : ecran_fin

func spawn_enemy(move_to_position = Vector2.ZERO):

	var obj = enemy_obj.instantiate() as Node2D
	add_child(obj)
		
	obj.global_position = move_to_position

	var health = obj.get_node("Area2D") as boss_health
	health.reset_health(fin)
	MusicController.start_boss_music()

func _on_timer_timeout() -> void:
	spawn_enemy()
