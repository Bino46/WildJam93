extends State

@onready var enemy : Node2D = $"../.." 

@export var speed_laser_spawn : float
@export var speed_laser_spawn_power : float
@export var x_step : float
@export var power : float

var enemy_script : boss
var player_ref : Node2D
var line : Line2D 
var raycast : RayCast2D

var t : float
var size_mod : float
var stop_spawn = false

func Enter() -> void:
	if(player_ref==null):
		var level = get_tree().get_root().get_node("MainLevel")
		player_ref = level.get_node("Player") as Node2D

		enemy_script = enemy as boss

		line = enemy.get_node("Line2D") as Line2D
		raycast = line.get_node("Raycast2D") as RayCast2D		
	
	
func Exit() -> void:
	pass
	
@warning_ignore("unused_parameter")
func Update(delta: float) -> void:

	if(!stop_spawn):
		setup_line(delta)
	
@warning_ignore("unused_parameter")
func Physics_update(delta: float) -> void:
	pass

func setup_line(delta):

	t += delta * speed_laser_spawn

	size_mod = pow(t, speed_laser_spawn_power)
	if(size_mod > 1):
		size_mod = 1

	var offset : Vector2
	var count = line.get_point_count()
	
	for i in range(count):

		offset.x = i * x_step * size_mod
		offset.y = pow(i, power) * size_mod

		line.set_point_position(i, offset)

	if(size_mod == 1):
		stop_spawn = true


