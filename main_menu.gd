extends Control

var main_scene = "res://main_level.tscn"
@onready var volume_slider = $ColorRect
@onready var animated_sprite = $AnimatedSprite2D
var can_press : bool = true


func _ready() -> void:
	MusicController.start_menu_music()
	
func _on_button_pressed(button_index : int) -> void:
	if button_index == 0 and can_press:
		can_press == false
		transition_animation()
		MusicController.stop_music()
		await animated_sprite.animation_finished
		get_tree().change_scene_to_file(main_scene)
		
		
	if button_index == 1:
		pass
	if button_index == 2:
		if volume_slider.visible == true:
			volume_slider.visible = false
		elif volume_slider.visible == false:
			volume_slider.visible = true
	if button_index == 3:
		get_tree().quit()
		
func transition_animation() -> void:
	var anim_name = "default"
	
	var frames = animated_sprite.sprite_frames
	var frame_count = float(frames.get_frame_count(anim_name))
	var fps = frames.get_animation_speed(anim_name)
	
	var anim_duration = frame_count / fps
	
	animated_sprite.play(anim_name)
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(animated_sprite, "position:x", 982, anim_duration)
