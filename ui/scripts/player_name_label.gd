extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Bridge.player.name:
		text = Bridge.player.name
	else:
		text = "Anonim"
