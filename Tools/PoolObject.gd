class_name PoolObject

extends Node2D

var is_active = false
var pool_ref : Pool
var foreign_parent

func change_state(state : bool, affect_active_instance_count : bool = true):

	self.visible = state
	set_process(state)
	is_active = state;
	position = Vector2.ZERO

	if(affect_active_instance_count):
		if(state):
			pool_ref.change_active_instance_count(1)
		else:
			pool_ref.change_active_instance_count(-1)
		
	if(foreign_parent):
		
		foreign_parent = false

		var pool_obj = pool_ref as Node
		self.reparent(pool_obj)
