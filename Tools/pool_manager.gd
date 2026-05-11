class_name pool_manager
extends Node

var pool_list : Dictionary[String, Pool]
static var _instance : pool_manager 

func _ready() -> void:
	_instance = self

func get_from_pool(pool_name) -> Node2D:
	var curr_pool = pool_list[pool_name] as Pool
	return curr_pool.get_instance()

func add_to_global_list(pool_name, pool):
	pool_list.set(pool_name, pool)
	print("Added " + pool_name + ", " + str(pool_list.size()) + " in dictionary.")
