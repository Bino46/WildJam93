extends Control

var main_scene = "res://main_level.tscn"
@onready var volume_slider = $ColorRect


func _on_button_pressed(button_index : int) -> void:
	if button_index == 0:
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
