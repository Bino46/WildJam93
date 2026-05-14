extends Node

@export var pool_reference : Pool

@export_category("Scene Objects")
@export var list_simple_spawners : Array[enemy_spawn]
@export var list_enemy_spots : Array[Node2D]
@export var list_wave_data : Array[wave_data]

@export_category("Parameters")
@export var time_between_enemy_spawns : float = 0.2
@export var time_between_waves : float = 0.35

var timer
var current_wave_data : wave_data
var current_wave_id = 0

func _ready() -> void:
	timer = time_between_waves

func _process(delta: float) -> void:

	if(!pool_reference.check_if_any_active()):
		timer = timer - delta

		if(timer <= 0):
			launch_wave()


func launch_wave():

	print(list_wave_data.size())

	current_wave_data = list_wave_data[current_wave_id]

	timer = time_between_waves

	for i in range(current_wave_data.simple_enemy_count):
		get_spawner(0, current_wave_data.simple_enemy_spot[i])
		await get_tree().create_timer(time_between_enemy_spawns).timeout
	
	for i in range(current_wave_data.flame_enemy_count):
		get_spawner(1, i)
		await get_tree().create_timer(time_between_enemy_spawns).timeout
	
	current_wave_id += 1
	
	
func get_spawner(spawner_id, enemy_id):

	match spawner_id:

		0:
			get_spot(list_simple_spawners, enemy_id)
		1:
			# get_spot(list_flame_spawners, enemy_id)
			pass
			
		

func get_spot(spawner, id):

	# dégueu mais je changerais plus tard (maybe)
	match id:
		0,1:
			spawner[0].spawn_enemy(list_enemy_spots[id].position)
		2,3:
			spawner[1].spawn_enemy(list_enemy_spots[id].position)
		
	
