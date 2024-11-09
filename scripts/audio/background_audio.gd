extends AudioStreamPlayer


# To track visibility state changes, connect to the signal
#func _ready():
	#Bridge.game.connect("visibility_state_changed", self, "_on_visibility_state_changed")


func _on_visibility_state_changed(state):
	match state:
		"hidden":
			_stop_music()
		"visible":
			_start_music()


func _start_music() -> void:
	play()


func _stop_music() -> void:
	stop()
