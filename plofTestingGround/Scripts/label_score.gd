extends Label


func _ready() -> void:
	Global.score_changed.connect(_on_score_changed)
	self.text = str(Global.score)
	
func _on_score_changed():
	self.text = str(Global.score)
