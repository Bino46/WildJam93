extends PlayerState

@onready var animation = $"../../AnimatedSprite2D3"
@onready var player = $"../.."

func Enter() -> void:
	player.disable_hurtbox()
	animation.play("roll")
	#Hitbox.disabled ?
	await animation.animation_finished
	#Hitbox réactivée
	transitioned.emit("Normal")
	
func Exit() -> void:
	player.enable_hurtbox()
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	player.velocity.x = 1.0 * move_speed
	player.move_and_slide()
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass
