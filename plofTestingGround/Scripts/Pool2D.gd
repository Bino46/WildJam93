class_name Pool2D
extends Node

static var pool_manager_instance
@export var object_reference = PackedScene.new()
@export var pool_name : String
@export var object_count = 10
var pool_list = []

func _ready():
	for i in range(object_count):
		make_instance()

	#pool_manager_instance = pool_manager._instance
	#pool_manager_instance.add_to_global_list(pool_name, self)

	
func make_instance() -> PoolObject2D:

	var pass_instance = object_reference.instantiate()

	pool_list.append(pass_instance)
	add_child(pass_instance)

	var obj = pass_instance as PoolObject2D
	obj.change_state(false)

	return pass_instance


func get_instance() -> Node2D:

	var returned_instance

	for i in range(pool_list.size()):
		if(pool_list[i].is_active == false):
			returned_instance = pool_list[i]
			
	if(returned_instance == null):
		make_instance()
		returned_instance = pool_list[pool_list.size() - 1]

	var obj = returned_instance as PoolObject2D
	obj.change_state(true)
	

	return returned_instance
