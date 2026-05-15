extends CharacterBody2D

@warning_ignore("unused_signal")
signal shooting

@export var cross_hair : Node
@export var level : Node
@export var shooting_rate : float = 0.1
@export var life : int = 2

#Pour les powerups
enum WeaponType {PISTOL, SHOTGUN}
@export var current_weapon = WeaponType.PISTOL

#Shotgun
var shotgun_ammo : int = 20
@export var max_shotgun_ammo : int = 20

@onready var hurtbox = $Hurtbox/CollisionShape2D

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
		
func switch_shotgun() -> void:
	current_weapon = WeaponType.SHOTGUN
	shotgun_ammo = max_shotgun_ammo
	
func switch_pistol():
	current_weapon = WeaponType.PISTOL
	
func disable_hurtbox() -> void:
	hurtbox.disabled = true
	
func enable_hurtbox() -> void:
	hurtbox.disabled = false
