extends PlayerState

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D3"

func Enter() -> void:
	player.hurtbox.disabled = true
	animated_sprite.play("die")
	player.life -= 1
	await animated_sprite.animation_finished
	if player.life <= 0:
		print("Game Over")
		get_tree().reload_current_scene()
	else:
		player.hurtbox.disabled = false
		transitioned.emit("Normal")
