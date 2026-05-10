extends Node2D

@export var move_to_position = Vector2.ZERO
@onready var enemy_pool 

func _ready() -> void:
	enemy_pool = pool_manager._instance.pool_list["Enemy"]

func spawn_enemy():
	var obj = enemy_pool.get_instance()
	obj.position = position
	obj.get_node("shooter_state").direction = move_to_position

func _on_timer_timeout() -> void:
	spawn_enemy()
