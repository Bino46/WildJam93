class_name boss
extends Node2D

@export var attack_cooldown : float = 5
@export var attack_count : int = 2
@export var score_added : float
var state_machine
var shoot_spot : Node2D
var player_ref

var cooldown = 0
var pause : bool

var is_protected = false

func _ready() -> void:
	var level = get_tree().get_root().get_node("MainLevel")
	player_ref = level.get_node("Player") as Node2D

	state_machine = get_node("StateMachine") as StateMachine
	shoot_spot = get_node("ShootSpot") as Node2D

func _process(delta: float) -> void:

	if(!pause):
		cooldown += delta

	if(cooldown >= attack_cooldown):
		attack()

func attack():
	pause = true
	var id = randi_range(0,attack_count-1)

	match id:
		0:
			state_machine.on_child_transitioned("SniperAttack")
		1:
			state_machine.on_child_transitioned("BulletAttack")
		2:
			state_machine.on_child_transitioned("FireAttack")

	reset()

func reset():
	cooldown = 0
	

func change_state():

	self.visible = false
	set_process(false)
	position = Vector2.ZERO

func reflect_bullet(shoot_pos):

	var reflected_proj = pool_manager._instance.get_from_pool("BulletEnemy") as Bullet
	reflected_proj.launch(player_ref.global_position, shoot_pos)
