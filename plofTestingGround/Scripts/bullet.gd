extends PoolObject2D

func launch(target_pos: Vector2, start_pos: Vector2):
	self.global_position = start_pos
	self.scale = Vector2(1, 1)
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.2)
	tween.parallel().tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	
	await tween.finished
	#Check collision ?
	change_state(false)
