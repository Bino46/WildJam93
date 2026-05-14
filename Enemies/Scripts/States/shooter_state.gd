class_name shooter_state
extends State

@onready var enemy = $"../.."

# Movement
@export var move_speed : int = 3
var direction : Vector2
var start_pos : Vector2
var is_retreating : bool = false

func set_direction(start, new_direction):
	start_pos = start
	direction = new_direction

# Shoot
@export var shoot_wait_time : float = 3
@export var wait_before_retreat : float = 2
