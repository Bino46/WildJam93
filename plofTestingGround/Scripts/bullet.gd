extends PoolObject
class_name Bullet

@export_group("Tween settings")
@export var travel_duration: float = 0.2
@export var final_scale: Vector2 = Vector2(0.5, 0.5)

@export_group("Bullet settings")
@export var hitbox_duration : float = 0.1
@export var layer : int
@export var hitbox_style : hitbox.hit_size = hitbox.hit_size.Small
var tween_timer = 0
var t = 0
var lerp_time = 0
var go : bool = false

var start_pos : Vector2
var target_pos : Vector2
var third_point : Vector2

var sprite_animation : Sprite2D
var anim_id :int = 0

const INITIAL_SCALE = Vector2.ONE

func _ready() -> void:
	sprite_animation = get_node("BulletSprite") as Sprite2D


func _process(delta: float) -> void:

	if(go):
		increment_time(delta)

# Setup variables
func launch(new_target_pos: Vector2, new_start_pos: Vector2, new_third_point : Vector2 = Vector2.ZERO):

	self.global_position = start_pos
	self.scale = INITIAL_SCALE

	start_pos = new_start_pos
	target_pos = new_target_pos
	third_point = new_third_point

	go = true

#Time related functions
func increment_time(delta : float):
	t += delta

	tween_timer = inverse_lerp(0, travel_duration, t)
	lerp_time = remap(tween_timer, 0, travel_duration, 0, 1)
	
	if(lerp_time > 1):
		lerp_time = 1

	if(third_point == Vector2.ZERO):
		self.global_position = lerp(start_pos, target_pos, lerp_time)
	else:
		bezier_move()

	scale = lerp(INITIAL_SCALE, final_scale, lerp_time)

	if(tween_timer >= travel_duration):
		finish_process()

#Bezier curve for the fireball
func bezier_move():

	var a = 1-lerp_time
	var b = lerp_time * lerp_time

	var new_pos = (a*a)*start_pos + 2*a*lerp_time*third_point + b * target_pos

	global_position = new_pos

#When reached destination, equivalent to tween.finished
func finish_process():
	var new_hitbox = pool_manager._instance.get_from_pool("Hitbox") as hitbox
	new_hitbox.init_hitbox(hitbox_duration, hitbox_style, layer, global_position)

	t = 0
	go = false
	change_state(false)

# Sprite animation
func _on_timer_timeout() -> void:

	anim_id += 1
	sprite_animation.frame = anim_id % 3
