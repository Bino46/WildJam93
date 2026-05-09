class_name State
extends Node

@warning_ignore("unused_signal")
signal transitioned(new_state_name: StringName)

func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	pass
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass
