extends PlayerState


@onready var player = $"../.."
var bullet = preload("res://plofTestingGround/scenes/bullet.tscn")

func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var target_pos = player.cross_hair.global_position
		var b = bullet.instantiate()
		player.level.add_child(b)
		b.global_position = player.global_position
		b.launch(target_pos)
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	player.velocity.x = direction * move_speed
	player.move_and_slide()
