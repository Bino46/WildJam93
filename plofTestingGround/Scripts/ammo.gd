extends Label

@onready var player : Node = $"../../Player"

func _process(delta: float) -> void:
	self.text = "x" + str(player.shotgun_ammo)
