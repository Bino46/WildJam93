class_name hitbox
extends PoolObject

enum hit_size {Small = 0, Long}
var small_hitbox : Area2D
var long_hitbox : Area2D

func _ready() -> void:
	small_hitbox = get_node("Bullet_Area2D") as Area2D
	long_hitbox = get_node("Flame_Area2D") as Area2D


func init_hitbox(timer : float, hitbox_size : hit_size, layer : int, new_pos : Vector2):
	
	global_position = new_pos 
	change_hitbox_state(hitbox_size, true, layer)

	await get_tree().create_timer(timer).timeout

	change_hitbox_state(hitbox_size, false, layer)
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

	for i in range(1, 6):

		area.set_collision_layer_value(i, false)

	area.set_collision_layer_value(layer, true)
