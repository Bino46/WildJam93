extends PoolObject
class_name Bullet

@export_group("Tween settings")
@export var travel_duration: float = 0.2
@export var final_scale: Vector2 = Vector2(0.5, 0.5)
@export_group("Bullet settings")
@export var hitbox_duration : float = 0.1
@export var layer : int

const INITIAL_SCALE = Vector2.ONE

func launch(target_pos: Vector2, start_pos: Vector2):
	self.global_position = start_pos
	self.scale = INITIAL_SCALE
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, travel_duration)
	tween.parallel().tween_property(self, "scale", final_scale, travel_duration)
	
	await tween.finished
	
	var new_hitbox = pool_manager._instance.get_from_pool("Hitbox") as hitbox
	new_hitbox.init_hitbox(hitbox_duration, hitbox.hit_size.Small, layer, global_position)

	change_state(false)
