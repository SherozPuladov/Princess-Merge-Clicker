class_name AdvertisementManager
extends Node


signal advertisement_opened()
signal advertisement_closed()


@onready var interstitial_timer: Timer = $InterstitialTimer
@onready var debug_manager: DebugManager = get_tree().get_nodes_in_group("DebugManager")[0]


func _ready() -> void:
	Bridge.advertisement.connect("interstitial_state_changed", _on_interstitial_state_changed)
	interstitial_timer.connect("timeout", _on_interstitial_timer_timeout)
	
	interstitial_timer.start()
	


func _on_interstitial_timer_timeout() -> void:
	Bridge.advertisement.show_interstitial()
	if debug_manager:
		debug_manager.print_debug_text_on_screen("interstitial timer is over")


func _on_interstitial_state_changed(state) -> void:
	match state:
		"opened":
			emit_signal("advertisement_opened")
			if debug_manager:
				debug_manager.print_debug_text_on_screen("interstitial opened")
		"closed":
			emit_signal("advertisement_closed")
			if debug_manager:
				debug_manager.print_debug_text_on_screen("interstitial closed")
		"failed":
			emit_signal("advertisement_closed")
			if debug_manager:
				debug_manager.print_debug_text_on_screen("interstitial failed")
	
	interstitial_timer.start()
