class_name shoot_script
extends Node2D

var player : Node2D
var player_chara : CharacterBody2D

var third_point : Vector2
@export var max_bezier_height : float = 50
@export var projection_amount : float

func _ready() -> void:
	var level = get_tree().get_root().get_node("MainLevel")
	player = level.get_node("Player") as Node2D
	player_chara = player as CharacterBody2D

func shoot_projectile(simple):

	if(simple):
		shoot_simple()
	else:
		shoot_fire()

func shoot_simple():

	var _proj = pool_manager._instance.get_from_pool("BulletEnemy") as Bullet
	_proj.launch(player.global_position, global_position)

func shoot_fire():
	third_point.y = max_bezier_height

	var player_projection = player_chara.global_position + player_chara.velocity * projection_amount
	
	third_point.x = global_position.x + (player_projection.x - global_position.x)
	
	var projectile = pool_manager._instance.get_from_pool("BulletFireEnemy") as Bullet
	projectile.launch(player_projection, global_position, third_point)

	pass
