extends AnimatedSprite2D

@onready var animation_player = $"../AnimationPlayer"

func _ready() -> void:
	animation_player.play("roll")
	self.play("default")
