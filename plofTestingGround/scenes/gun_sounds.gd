extends Node

@onready var gun_shots : Array = [$Gun1, $Gun2, $Gun3, $Gun4, $Gun5, $Gun6, $Gun7]

func gun_shot_sound() -> void:
	gun_shots.pick_random().play()

func shotgun_sound() ->void:
	$shotgun.play()
