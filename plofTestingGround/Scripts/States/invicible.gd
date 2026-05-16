extends PlayerState

@onready var normal = $"../Normal"
@onready var timer : Timer = $"../../Invicibletimer"
@onready var player = $"../.."
func Enter() -> void:
	$"../../AnimationPlayer".play("invicible")
	player.disable_hurtbox()
	timer.start()
	normal.Enter()
func Exit() -> void:
	normal.Exit()
	player.enable_hurtbox()
func Update(delta: float) -> void:
	normal.Update(delta)
func Physics_update(delta: float) -> void:
	normal.Physics_update(delta)


func _on_invicibletimer_timeout() -> void:
	transitioned.emit("Normal")
