class_name shoot_script
extends Node2D

var player : Node2D

func _ready() -> void:
	var level = get_tree().get_root().get_node("MainLevel")
	player = level.get_node("Player") as Node2D

func shoot_projectile(simple):

	if(simple):
		shoot_simple()
	else:
		shoot_fire()

func shoot_simple():

	var _proj = pool_manager._instance.get_from_pool("BulletEnemy") as Bullet
	_proj.launch(player.global_position, global_position)

func shoot_fire():
	pass