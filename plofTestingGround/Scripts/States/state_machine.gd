class_name StateMachine
extends Node

@export var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child wich is not 'State'")

	if current_state:
		current_state.Enter()
	else:
		push_warning("Initial current_state is not assigned in the inspector!")

func _process(delta):
	if current_state:
		current_state.Update(delta)
	
func _physics_process(delta):
	if current_state:
		current_state.Physics_update(delta)
	
func on_child_transitioned(new_state_name: StringName) -> void:
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.Exit()
			new_state.Enter()
			current_state = new_state
			
	else:
		push_warning("Called transition on a state that does not exist")
