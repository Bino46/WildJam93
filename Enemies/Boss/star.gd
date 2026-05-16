extends PoolObject

@export var speed : float
var direction : Vector2 = Vector2.ONE
var raycast : RayCast2D
var test

func _ready() -> void:
	raycast = get_node("Area2D/RayCast2D")
	test = get_node("Area2D/test")

	direction.x = randf_range(-1,1)
	direction.y = randf_range(-1,1)


func _process(delta: float) -> void:

	global_position += direction.normalized() * speed * delta
	raycast.target_position = raycast.position + direction.normalized() * 40000
	test.position = raycast.target_position


func _on_area_2d_area_entered(area: Area2D) -> void:

	if(area.get_collision_layer_value(4)):
		var new_direction : Vector2

		new_direction = raycast.get_collision_normal()
		direction = direction.bounce(new_direction)
	
	if(area.get_collision_layer_value(2)):
		change_state(false)
