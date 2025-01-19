extends Node2D


signal switch_buy_princess_panel_visibility()



@onready var princesses: Node2D = get_tree().get_nodes_in_group("Princesses")[0]



func _ready() -> void:
	if princesses.get_child_count() == 0:
		PrincessManager._spawn_princess(0)
	#if Bridge.platform.id:
		#Bridge.platform.send_message(Bridge.PlatformMessage.GAME_READY)
		#Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STARTED)


func _input(event: InputEvent) -> void:
	if event.is_action_released("open_buy_panel"):
		emit_signal("switch_buy_princess_panel_visibility")
