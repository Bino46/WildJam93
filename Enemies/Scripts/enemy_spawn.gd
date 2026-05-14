class_name enemy_spawn
extends Node2D

@onready var enemy_pool 

func _ready() -> void:
	enemy_pool = pool_manager._instance.pool_list["Enemy"]

func spawn_enemy(move_to_position = Vector2.ZERO):
	var obj = enemy_pool.get_instance()
	obj.position = position

	var enemy = obj as simple_enemy
	enemy.set_direction(position, move_to_position)
	enemy.set_origin(global_position)

func _on_timer_timeout() -> void:
	spawn_enemy()
