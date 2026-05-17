class_name EnemyHealth
extends Node2D

@export var _health : float = 3
var current_health

@export var proba_drop : int

@export var color_flash : Color
@export var color_normal : Color
var enemy_sprite : AnimatedSprite2D

var test_val: int
var dropped:bool
var shotgun_bonus = preload("res://plofTestingGround/scenes/power_up_shotgun.tscn")

func _ready() -> void:
	current_health = _health
	enemy_sprite = get_parent().get_node("AnimatedSprite2D")

func take_damage():

	current_health -= 1

	enemy_sprite.modulate = color_flash
	await get_tree().create_timer(0.1).timeout
	enemy_sprite.modulate = color_normal
	
	if(current_health <= 0):

		drop_shotgun()

		var state = get_node("../StateMachine") as StateMachine
		state.on_child_transitioned("Idle")

		var parent = get_parent() as simple_enemy
		Global.add_score(parent.score_added)
		parent.change_state(false)

func reset_health():
	current_health = _health
	dropped = false

func _on_area_entered(area: Area2D) -> void:
	if(area.get_collision_layer_value(2)):
		take_damage()

func drop_shotgun():

	test_val = randi_range(0,100)
	if(test_val <= proba_drop && !dropped):
		call_deferred("deferred_drop")

func deferred_drop():
	dropped = true
	var drop = shotgun_bonus.instantiate() as Node2D

	drop.global_position = global_position

	var level = get_tree().get_root().get_node("MainLevel")

	level.add_child(drop)
		
