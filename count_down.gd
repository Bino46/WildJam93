extends Label

@onready var ennemy_spawn = $"../../EnemySpawnManager"
var wave : String

func _ready() -> void:
	ennemy_spawn.wave_changed.connect(_on_wave_changed)
	wave = ennemy_spawn.get_wave()
	self.text = wave
	
	
	
func _on_wave_changed() -> void:
	wave = ennemy_spawn.get_wave()
	self.text = wave
