extends State

@onready var enemy : Node2D = $"../.."
var enemy_script : boss
@export var projectile_count : int = 15
@export var fire_rate : float = 0.2 
@export var precision_radius : float = 1
var player_ref : Node2D

func Enter() -> void:

	if(player_ref==null):
		var level = get_tree().get_root().get_node("MainLevel")
		player_ref = level.get_node("Player") as Node2D
		enemy_script = enemy as boss

	shoot_bullet()
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	pass
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass

func get_player_approximate_position() -> Vector2:
	var rdm = randf_range(-precision_radius, precision_radius)
	var rdm_circle = randf_range(-1, 1)

	var approximation : Vector2
	approximation.x = player_ref.global_position.x + cos(rdm_circle) * rdm
	approximation.y = player_ref.global_position.y + sin(rdm_circle) * rdm

	return approximation

func shoot_bullet():

	for i in range(projectile_count):

		var obj = pool_manager._instance.get_from_pool("BulletEnemy") as Bullet
		obj.launch(get_player_approximate_position(), enemy_script.shoot_spot.global_position)

		await get_tree().create_timer(fire_rate).timeout
	
	var state = enemy.get_node("StateMachine") as StateMachine
	enemy_script.pause = false
	state.on_child_transitioned("Walk")
