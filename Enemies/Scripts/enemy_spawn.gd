class_name enemy_spawn
extends Node2D

@onready var enemy_pool
@export var pool_name : String

func _ready() -> void:
	enemy_pool = pool_manager._instance.pool_list[pool_name]

func spawn_enemy(move_to_position = Vector2.ZERO, new_parent : Control = null):

	var obj = null

	if(new_parent != null):
		obj = enemy_pool.get_instance(true, new_parent)
	else:
		obj = enemy_pool.get_instance()
		
	obj.position = position

	var enemy = obj as simple_enemy
	enemy.set_direction(position, move_to_position)
	enemy.set_origin(global_position)

	var health = obj.get_node("Area2D") as EnemyHealth
	health.reset_health()

func _on_timer_timeout() -> void:
	spawn_enemy()
