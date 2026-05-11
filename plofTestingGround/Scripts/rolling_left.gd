extends PlayerState

@onready var animation = $"../../AnimationPlayer"
@onready var player = $"../.."

func Enter() -> void:
	animation.play("rolling_left")
	#Hitbox.disabled ?
	await animation.animation_finished
	#Hitbox réactivée
	transitioned.emit("Normal")
	
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	player.velocity.x = -1.0 * move_speed
	player.move_and_slide()
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass
