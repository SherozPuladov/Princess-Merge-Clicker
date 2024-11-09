extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Bridge.platform.id:
		text = Bridge.platform.id
