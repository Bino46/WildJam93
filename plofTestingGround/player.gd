class_name player_script

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
var shotgun_ammo : int = 0
@export var max_shotgun_ammo : int = 20

@onready var hurtbox = $Hurtbox/CollisionShape2D
@onready var animated_sprite = $AnimatedSprite2D3
@onready var animation_player = $AnimationPlayer

@onready var state_machine = $StateMachine

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
func die() -> void:
	state_machine.current_state.transitioned.emit("Die")

#func die() -> void:
	#life -= 1
	#if life <= 0:
		#print ("Game Over")
	##Animation game over, retour au menu
	#else:
		##Animation mort, puis remis debout
		#print("C'est reparti")
		##Logique de remise en jeu


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(3):
		die()
		
func switch_shotgun() -> void:
	current_weapon = WeaponType.SHOTGUN
	shotgun_ammo = max_shotgun_ammo
	
func switch_pistol():
	current_weapon = WeaponType.PISTOL
	
func disable_hurtbox() -> void:
	hurtbox.set_deferred("disabled", true)
	
func enable_hurtbox() -> void:
	hurtbox.set_deferred("disabled", false)
	
func start_invicibility(duration : float = 1.5) -> void:
	disable_hurtbox()
	animation_player.play("invicible")
	await get_tree().create_timer(duration).timeout
	
	enable_hurtbox()
	animation_player.play("RESET")
	
	
