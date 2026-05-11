class_name PoolObject

extends Node

var is_active = false
var visible_part

func get_visible_part() -> void:
	visible_part = get_node(self.get_path().slice(0,-1)) as Node2D

func change_state(state):

	# if(visible_part == null):
	# 	get_visible_part()

	self.visible = state
	set_process(state)
	is_active = state;
