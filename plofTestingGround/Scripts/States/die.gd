extends PlayerState

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D3"


func Enter() -> void:
	player.disable_hurtbox()
	animated_sprite.play("die")
	player.life -= 1
	await animated_sprite.animation_finished
	if player.life <= 0:
		print("Game Over")
		Global.reset_score()
		get_tree().reload_current_scene()
	else:
		player.start_invicibility(2.0)
		transitioned.emit("Normal")
