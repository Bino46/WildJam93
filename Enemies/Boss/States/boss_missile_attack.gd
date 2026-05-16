extends State

@export var speed : float
@onready var enemy : Node2D = $"../.." 
var enemy_script : boss
var player : Node2D

func Enter() -> void:
	if(player==null):
		var level = get_tree().get_root().get_node("MainLevel")
		player = level.get_node("Player") as Node2D
		enemy_script = enemy as boss
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	pass
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass
