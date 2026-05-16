extends Node2D

@onready var player = $"../Player"

#func _ready() -> void:
	#player.powerup_shotgun.connect()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_collision_layer_value(2)):		
		#animation
		player.switch_shotgun()
		queue_free()
	
