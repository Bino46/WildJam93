class_name hitbox
extends PoolObject

enum hit_size {Small = 0, Long}
var small_hitbox : Area2D
var long_hitbox : Area2D

var sprite_animation : Sprite2D
var anim_id :int = 0

func _ready() -> void:
	small_hitbox = get_node("Bullet_Area2D") as Area2D
	long_hitbox = get_node("Flame_Area2D") as Area2D


func init_hitbox(timer : float, hitbox_size : hit_size, layer : int, new_pos : Vector2):
	
	global_position = new_pos 
	change_hitbox_state(hitbox_size, true, layer)

	await get_tree().create_timer(timer).timeout

	change_hitbox_state(hitbox_size, false, layer)
	reset_layer()
	change_state(false)


func change_hitbox_state(hitbox_size : hit_size, activate : bool, layer : int):

	match hitbox_size:

		hit_size.Small:
			small_hitbox.monitorable = activate
			if(!small_hitbox.get_collision_layer_value(layer)):
				set_layer(layer, small_hitbox)

		hit_size.Long:
			long_hitbox.monitorable = activate
			if(!long_hitbox.get_collision_layer_value(layer)):
				set_layer(layer, long_hitbox)
	

func set_layer(layer : int, area):
	
	area.set_collision_layer_value(layer, true)

	# var sprite = area.get_node("MeshInstance2D") as MeshInstance2D
	sprite_animation = area.get_node("Sprite2D") as Sprite2D

	if(area == small_hitbox):

		if(layer == 2):
			sprite_animation = area.get_node("PlayerSprite2D") as Sprite2D

		elif(layer == 3):
			sprite_animation = area.get_node("Sprite2D") as Sprite2D

	sprite_animation.visible = true

func reset_layer():

	sprite_animation.visible = false
	small_hitbox.set_collision_layer_value(2, false)
	small_hitbox.set_collision_layer_value(3, false)

	sprite_animation.visible = false
	long_hitbox.set_collision_layer_value(2, false)
	long_hitbox.set_collision_layer_value(3, false)


func _on_timer_timeout() -> void:
	anim_id += 1

	if(sprite_animation != null):
		sprite_animation.frame = anim_id % sprite_animation.hframes
