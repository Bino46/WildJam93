extends Node2D

@onready var player = $"../Player"

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_collision_layer_value(2)):
		player.switch_shotgun()
		queue_free()
	
