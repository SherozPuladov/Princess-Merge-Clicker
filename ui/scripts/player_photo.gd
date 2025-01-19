extends TextureRect


func _ready() -> void:
	if Bridge.player:
		texture = Bridge.player
