extends CharacterBody2D

@warning_ignore("unused_signal")
signal shooting
@onready var cross_hair = $"../CrossHair"
@onready var level = $".."
@export var shooting_rate : float = 0.1
@export var life : int = 2

#Pour les powerups
enum WeaponType {PISTOL, SHOTGUN}
@export var current_weapon = WeaponType.PISTOL

func die() -> void:
	life -= 1
	if life <= 0:
		print ("Game Over")
	#Animation game over, retour au menu
	else:
		#Animation mort, puis remis debout
		print("C'est reparti")
		#Logique de remise en jeu


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is bullet_hitbox:
		die()
