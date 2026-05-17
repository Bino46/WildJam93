class_name wave_data 
extends Resource

enum SPOTS {Middle1 = 0, Middle2, Middle3, Roof1, Roof2, Air1, Air2}

@export var simple_enemy_count : int
@export var flame_enemy_count : int
@export var simple_enemy_spot : Array[SPOTS]
@export var flame_enemy_spot : Array[SPOTS]
