class_name ecran_fin
extends Control

var main_menu = "res://main_menu.tscn"

func appear():
	self.visible = true
	get_tree().paused = true
	get_score()
	
func get_score():
	$ColorRect/Label2.text = "SCORE :" + str(Global.score)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu)
