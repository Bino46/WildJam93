class_name PoolObject

extends Node2D

var is_active = false

func change_state(state):

	self.visible = state
	set_process(state)
	is_active = state;
