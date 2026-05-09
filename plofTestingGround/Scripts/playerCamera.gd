extends Camera2D

@export var background : Sprite2D

func _ready() -> void:
	var rect = background.get_rect()
	var camerascale = background.global_scale

	limit_left = background.global_position.x + (rect.position.x * camerascale.x)
	limit_right = background.global_position.x + (rect.end.x * camerascale.x)
