extends Node

@onready var pistol_sounds = $GunShots

func shotgun_sound() ->void:
	$shotgun.play()

func gun_shot_sound() -> void:
	pistol_sounds.play()
	
