extends Camera2D

@export var background : Sprite2D

@export var shake_noise: FastNoiseLite
var shake_intensity: float = 0.0
var noise_i : float = 0.0

func _ready() -> void:
	shake_noise = FastNoiseLite.new()
	var rect = background.get_rect()
	var camerascale = background.global_scale

	limit_left = background.global_position.x + (rect.position.x * camerascale.x)
	limit_right = background.global_position.x + (rect.end.x * camerascale.x)

func _process(delta: float) -> void:
	if shake_intensity > 0:
		noise_i += delta * 50.0
		
		offset.x = shake_noise.get_noise_2d(1, noise_i) * shake_intensity
		offset.y = shake_noise.get_noise_2d(100, noise_i) * shake_intensity
		
		shake_intensity = lerp(shake_intensity, 0.0, delta * 10)
		
func add_shake(amount: float) -> void:
	shake_intensity += amount
