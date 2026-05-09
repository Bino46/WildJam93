extends Sprite2D
	
func launch(target_pos: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.2)
	tween.parallel().tween_property(self, "scale", Vector2(5, 5), 0.2)
	
	await tween.finished
	#Check collision ?
	queue_free()
