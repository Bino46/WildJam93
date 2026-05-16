extends PlayerState


@onready var player = $"../.."
@export var timer_next_shot: Timer
#Pistolet:
@export var firing_rate : float = 0.1
#Shotgun
@export var shotgun_rate : float = 0.5
@onready var bullet_pool = $"../../../PoolPlayerBullet"
@onready var animated_sprite = $"../../AnimatedSprite2D3"
@onready var camera = $"../../Camera2D"

func Enter() -> void:
	animated_sprite.play("default")
	timer_next_shot.wait_time = firing_rate
	timer_next_shot.one_shot = true
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	#Le shoot est dans ce state, puisque c'est le seul qui le permet
	if Input.is_action_pressed("shoot") and timer_next_shot.is_stopped():
		shoot()
		if player.current_weapon == player.WeaponType.SHOTGUN:
			timer_next_shot.start(shotgun_rate)
		else:
			timer_next_shot.start(firing_rate)
	#Esquive/Saut ?
	if Input.is_action_just_pressed("jump") and direction != 0:
		if direction > 0:
			transitioned.emit("RollingRight")
		elif direction < 0:
			transitioned.emit("RollingLeft")
		else:
			push_error("Pas de direction ?")
	elif Input.is_action_just_pressed("jump") and direction == 0:
		transitioned.emit("Jump")
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	direction = Input.get_axis("left", "right")
	player.velocity.x = direction * move_speed
	player.move_and_slide()
	change_animation()
	
func change_animation() -> void:
	if player.velocity.x > 0:
		animated_sprite.play("walk_right")
	elif player.velocity.x < 0:
		animated_sprite.play("walk_left")
	elif player.velocity.x == 0:
		animated_sprite.play("default")
	else:
		print("T'as oublié un truc")
	
func shoot() -> void:
	var target_pos = player.cross_hair.global_position
	var player_pos = player.global_position
	
	match player.current_weapon:
		player.WeaponType.PISTOL:
			fire_bullet(target_pos, player_pos)
		player.WeaponType.SHOTGUN:
			fire_shotgun(target_pos, player_pos)
	
	
func fire_bullet(target: Vector2, origin: Vector2) -> void:
	var b = bullet_pool.get_instance()
	b.global_position = player.global_position
	b.launch(target, origin)
	camera.add_shake(3.0)
	
func fire_shotgun(target_center: Vector2, origin: Vector2) -> void:
	var pellets = 5
	var spread_radius = 40.0
	camera.add_shake(30.0)
	
	for i in range(pellets):
		var angle = randf() * TAU
		var distance = randf() * spread_radius
		var offset = Vector2(cos(angle), sin(angle)) * distance
		
		var specific_target = target_center + offset
		var b = bullet_pool.get_instance()
		b.global_position = origin
		b.launch(specific_target, origin)
	player.shotgun_ammo -= 1
	print(player.shotgun_ammo)
	if player.shotgun_ammo <= 0:
		player.switch_pistol()
#func shoot():
	#var target_pos = player.cross_hair.global_position
	#var player_pos = player.global_position
	#var b = bullet_pool.get_instance()
	##player.level.add_child(b)
	#b.global_position = player.global_position
	#b.launch(target_pos, player_pos)
