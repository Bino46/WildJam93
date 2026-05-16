class_name boss
extends Node2D

@export var attack_cooldown : float = 5
@export var attack_count : int = 2
@export var score_added : float
var state_machine
var shoot_spot : Node2D

var cooldown = 0
var pause : bool

func _ready() -> void:
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
			state_machine.on_child_transitioned("FireAttack")
		1:
			state_machine.on_child_transitioned("BulletAttack")

	reset()

func reset():
	cooldown = 0
	

func change_state():

	self.visible = false
	set_process(false)
	position = Vector2.ZERO
