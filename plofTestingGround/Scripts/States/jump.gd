extends PlayerState

@onready var player = $"../.."
@onready var animation = $"../../AnimatedSprite2D3"
@onready var jump_player = $"../../AnimationPlayer"
@onready var hurtbox = $"../../Hurtbox/CollisionShape2D"

func Enter() -> void:
	player.disable_hurtbox()
	animation.play("jump")
	jump_player.play("jump")
	await animation.animation_finished
	transitioned.emit("Normal")
	
func Exit() -> void:
	player.enable_hurtbox()
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	pass
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass
