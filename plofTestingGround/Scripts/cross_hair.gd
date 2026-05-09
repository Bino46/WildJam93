extends Sprite2D

@export var cross_speed: float = 500.0
@onready var player = $"../Player"

var is_moving: bool = false
var scale_tween: Tween

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.get_connected_joypads().size() > 0:
		var input_dir = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
		global_position += input_dir * cross_speed * delta
	else:
		global_position = get_global_mouse_position()
		
	lose_accuracy()
	clamp_to_camera()
		
		
func lose_accuracy() -> void:
	var currently_moving = (player.velocity.x != 0)
	
	if currently_moving != is_moving:
		is_moving = currently_moving
		
		if scale_tween:
			scale_tween.kill()
			
		scale_tween = get_tree().create_tween()
		var target_scale = Vector2(1.25, 1.25) if is_moving else Vector2(1.0, 1.0)
		scale_tween.tween_property(self, "scale", target_scale, 0.2)

func clamp_to_camera() -> void:
	var canvas_transform = get_canvas_transform()
	var top_left = -canvas_transform.origin / canvas_transform.get_scale()
	var size = get_viewport_rect().size / canvas_transform.get_scale()
	var bottom_right = top_left + size
	
	var margin = 16.0
	
	global_position.x = clamp(global_position.x, top_left.x + margin, bottom_right.x - margin)
	global_position.y = clamp(global_position.y, top_left.y + margin, bottom_right.y - margin)
