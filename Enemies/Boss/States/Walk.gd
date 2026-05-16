extends State

@export var speed : float
@onready var enemy : Node2D = $"../.." 
var player_ref : Node2D

func Enter() -> void:
	if(player_ref==null):
		var level = get_tree().get_root().get_node("MainLevel")
		player_ref = level.get_node("Player") as Node2D
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	enemy.global_position.x = move_toward(enemy.global_position.x, player_ref.global_position.x, speed*delta)
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass
