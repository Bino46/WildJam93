extends PoolObject

@export var speed : float
var direction : Vector2 = Vector2.ONE
var raycast : RayCast2D

var sprite_animation : Sprite2D
var anim_id :int = 0

func _ready() -> void:
	sprite_animation = get_node("Sprite2D") as Sprite2D
	raycast = get_node("Area2D/RayCast2D")

	direction.x = randf_range(-1,1)
	direction.y = randf_range(-1,1)


func _process(delta: float) -> void:

	global_position += direction.normalized() * speed * delta
	raycast.target_position = raycast.position + direction.normalized() * 40000


func _on_area_2d_area_entered(area: Area2D) -> void:

	if(area.get_collision_layer_value(4)):
		var new_direction : Vector2

		new_direction = raycast.get_collision_normal()
		direction = direction.bounce(new_direction)
	
	if(area.get_collision_layer_value(2)):
		change_state(false)


func _on_timer_timeout() -> void:
	anim_id += 1
	sprite_animation.frame = anim_id % 3
