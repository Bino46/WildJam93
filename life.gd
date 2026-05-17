extends Node2D

@onready var player = $"../../Player"
@onready var anim = $AnimationPlayer

func _ready() -> void:
	anim.play("2 life")
	player.died.connect(_on_player_died)
	
func _on_player_died(life):
	if life == 1:
		anim.play("1 life")
	if life <= 0:
		anim.play("0 life")
