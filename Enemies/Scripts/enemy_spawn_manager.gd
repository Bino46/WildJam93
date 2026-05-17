extends Node

signal wave_changed

var simple_pool_reference : Pool
var flame_pool_reference : Pool

@export_category("Scene Objects")
@export var list_simple_spawners : Array[enemy_spawn]
@export var list_flame_spawners : Array[enemy_spawn]
@export var list_enemy_spots : Array[Node2D]
@export var list_wave_data : Array[wave_data]
@export var boss_spawner : boss_spawn

@export_category("Parameters")
@export var time_between_enemy_spawns : float = 0.2
@export var time_between_waves : float = 0.35

var timer
var current_wave_id = 0
var boss_alive : bool

func _ready() -> void:
	simple_pool_reference = pool_manager._instance.pool_list["Enemy"]
	flame_pool_reference = pool_manager._instance.pool_list["FlameEnemy"]
	
	timer = time_between_waves


func _process(delta: float) -> void:

	if(!simple_pool_reference.check_if_any_active() && !flame_pool_reference.check_if_any_active() && !boss_alive):
		timer = timer - delta
		
		if(timer <= 0 && current_wave_id < list_wave_data.size()):
			launch_wave()

		if(current_wave_id > list_wave_data.size()):
			current_wave_id = 0


func launch_wave():
	wave_changed.emit()

	timer = time_between_waves
	
	var current_wave_data = list_wave_data[current_wave_id]

	for i in range(current_wave_data.simple_enemy_count):
		get_spawner(0, current_wave_data.simple_enemy_spot[i])
		await get_tree().create_timer(time_between_enemy_spawns).timeout
	
	for i in range(current_wave_data.flame_enemy_count):
		get_spawner(1, current_wave_data.flame_enemy_spot[i])
		await get_tree().create_timer(time_between_enemy_spawns).timeout

	if(current_wave_data.is_boss_spawn):
		get_spawner(2, current_wave_data.boss_enemy_spot[0])
		boss_alive = true
	
	current_wave_id += 1
	
	
func get_spawner(spawner_id, enemy_id):

	match spawner_id:

		0:
			get_spot(list_simple_spawners, enemy_id)
		1:
			get_spot(list_flame_spawners, enemy_id)
		2:
			boss_spawner.spawn_enemy(list_enemy_spots[0].position)
			pass
			
		

func get_spot(spawner, id):

	# dégueu mais je changerais plus tard (maybe)
	match id:
		0,1:
			spawner[0].spawn_enemy(list_enemy_spots[id].position)
		2,3:
			spawner[1].spawn_enemy(list_enemy_spots[id].position)
		4,5:
			# var spot_parent = list_enemy_spots[id] as Node2D
			# spawner[0].spawn_enemy(list_enemy_spots[id].position, spot_parent.get_child(0) as Control)
			spawner[0].spawn_enemy(list_enemy_spots[id].position)
		6:
			# var spot_parent = list_enemy_spots[id] as Node2D
			# spawner[1].spawn_enemy(list_enemy_spots[id].position, spot_parent.get_child(0) as Control)
			spawner[1].spawn_enemy(list_enemy_spots[id].position)
		
	
func get_wave() -> String:
	var val = str("Wave ", current_wave_id, " / ",list_wave_data.size()) 
	return val
