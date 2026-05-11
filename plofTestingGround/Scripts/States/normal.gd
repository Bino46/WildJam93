extends PlayerState


@onready var player = $"../.."
var bullet = preload("res://plofTestingGround/scenes/bullet.tscn")
@onready var timer_next_shot: Timer = $"../../Timer"
@export var firing_rate : float = 0.1

func Enter() -> void:
	timer_next_shot.wait_time = firing_rate
	timer_next_shot.one_shot = true
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	#Le shoot est dans ce state, puisque c'est le seul qui le permet
	if Input.is_action_pressed("shoot") and timer_next_shot.is_stopped():
		shoot()
		timer_next_shot.start()
	#Esquive/Saut ?
	if Input.is_action_just_pressed("jump") and direction != 0:
		if direction > 0:
			transitioned.emit("RollingRight")
		elif direction < 0:
			transitioned.emit("RollingLeft")
		else:
			push_error("Pas de direction ?")
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	player.velocity.x = direction * move_speed
	player.move_and_slide()
	
	
	
func shoot():
	var target_pos = player.cross_hair.global_position
	var b = bullet.instantiate()
	player.level.add_child(b)
	b.global_position = player.global_position
	b.launch(target_pos)
