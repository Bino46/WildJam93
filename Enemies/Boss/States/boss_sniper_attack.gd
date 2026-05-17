extends State

@onready var enemy : Node2D = $"../.." 

@export var charge_time : float
@export var charge_sprite_size : float
@export var charge_sprite_rotation : float
@export var star_count : int

var star_pool : Pool

var enemy_script : boss
var player_ref : Node2D

var aim_line : Line2D 
var aim_sprite : Sprite2D

var line_shoot : Node2D
var current_charge : float = 0


func Enter() -> void:
	if(player_ref==null):
		var level = get_tree().get_root().get_node("MainLevel")
		player_ref = level.get_node("Player") as Node2D

		enemy_script = enemy as boss

		aim_line = enemy.get_node("AimLine2D") as Line2D
		aim_sprite = aim_line.get_node("Sprite2D") as Sprite2D

		line_shoot = get_node("../../SniperProjectile") as Node2D

	enemy_script.is_protected = true
	aim_line.visible = true

	current_charge = 0

	show_stars()
	
func Exit() -> void:
	aim_line.visible = false
	enemy_script.is_protected = false
	enemy_script.pause = false
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	aim_line_point(delta)

	current_charge += delta

	if(!star_pool.check_if_any_active()):
		yeet()
	
	if(current_charge >= charge_time):
		sniper_shoot()

	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass


func aim_line_point(delta):

	aim_line.set_point_position(0, enemy_script.shoot_spot.position)

	var aim_pos = enemy.to_local(player_ref.global_position)
	aim_pos.y -= 75
	aim_line.set_point_position(1, aim_pos)

	aim_sprite.scale = charge_sprite_size * (Vector2.ONE * inverse_lerp(charge_time, 0, current_charge))

	aim_sprite.rotate(charge_sprite_rotation * delta)


func sniper_shoot():
	line_shoot.look_at(player_ref.global_position)

	var hit_player = player_ref as player_script
	hit_player.die()

	enemy_script.state_machine.on_child_transitioned("Walk")

func show_stars():
	star_pool = pool_manager._instance.pool_list["StarPool"]
	for i in range(star_count):
		var star = star_pool.get_instance()
		star.global_position = enemy_script.shoot_spot.global_position

func yeet():
	enemy_script.state_machine.on_child_transitioned("Walk")
