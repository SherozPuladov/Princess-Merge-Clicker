extends TextureRect


@onready var debug_manager: DebugManager = get_tree().get_first_node_in_group("DebugManager")


func _ready() -> void:
	if Bridge.player:
		if Bridge.player.photos.size() > 0:
			texture = Bridge.player.photos[Bridge.player.photos.size()-1]
