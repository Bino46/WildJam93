extends State

@onready var enemy : Node2D = $"../.."
var enemy_script : boss
@export var projectile_count : int = 3
@export var max_angle : float = 45
@export var max_bezier_height = 10
var finished

var player_ref : Node2D

func Enter() -> void:
	finished = false
	if(enemy_script == null):
		var level = get_tree().get_root().get_node("MainLevel")
		player_ref = level.get_node("Player") as Node2D
		enemy_script = enemy as boss

	throw_semi_circle()
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:
	if(finished):
		var state = enemy.get_node("StateMachine") as StateMachine
		enemy_script.pause = false
		state.on_child_transitioned("Walk")
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass

func throw_semi_circle():

	var step = max_angle / projectile_count
	var start_point = enemy.global_position.x
	var new_pos : Vector2
	var direction_sign = 1
	var start = 0

	new_pos.y = player_ref.global_position.y

	for i in range(projectile_count):

		if(direction_sign < 0):
			start += step

		new_pos.x = start_point + start * direction_sign

		var obj = pool_manager._instance.get_from_pool("BulletFireEnemy") as Bullet
		obj.launch(new_pos, enemy_script.shoot_spot.global_position, get_third_point(new_pos))

		direction_sign = direction_sign * -1

	finished = true

func get_third_point(ground_pos) -> Vector2:
	var third_point : Vector2

	third_point.y = max_bezier_height - abs(ground_pos.x - enemy.global_position.x) * 0.25
	
	third_point.x = enemy.global_position.x + (ground_pos.x - enemy.global_position.x)

	return third_point
