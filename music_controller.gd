extends Node

@onready var menu = $Menu
@onready var main = $MainTheme
@onready var bossmusic = $Boss

@export var fade_duration: float = 1.5

func start_menu_music() -> void:
	if menu.playing : return
	
	stop_music()
	menu.play()
	
func start_main_music() -> void:
	if main.playing : return
	
	stop_music()
	main.play()

func start_boss_music() -> void:
	if bossmusic.playing : return
	
	stop_music()
	bossmusic.play()
	

func stop_music() -> void:
	for child in self.get_children():
		if child is AudioStreamPlayer and child.playing:
			fade_out(child)
			
func fade_out(player: AudioStreamPlayer) -> void:
	var original_volume = player.volume_db 
	
	var tween = create_tween()
	tween.tween_property(player, "volume_db", -80.0, fade_duration)
	
	tween.tween_callback(func():
		player.stop()
		player.volume_db = original_volume
	)
	
	
