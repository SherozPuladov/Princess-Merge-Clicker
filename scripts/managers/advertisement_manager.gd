class_name AdvertisementManager
extends Node



signal advertisement_opened()
signal advertisement_closed()
signal advertisement_failed()

signal reward_advertisement_opened()
signal reward_advertisement_closed()
signal reward_advertisement_failed()
signal reward_advertisement_rewarded()



@onready var interstitial_timer: Timer = $InterstitialTimer
@onready var debug_manager: DebugManager = get_tree().get_nodes_in_group("DebugManager")[0]



func _ready() -> void:
	Bridge.advertisement.connect("interstitial_state_changed", _on_interstitial_state_changed)
	interstitial_timer.connect("timeout", _on_interstitial_timer_timeout)
	
	interstitial_timer.start()
	
	Bridge.advertisement.connect("reward_state_changed", _on_reward_state_changed)
	


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
			emit_signal("advertisement_failed")
			if debug_manager:
				debug_manager.print_debug_text_on_screen("interstitial failed")
	
	interstitial_timer.start()



func show_reward_advertisement() -> void:
	Bridge.advertisement.show_rewarded()


func _on_reward_state_changed(state):
	match state:
		"opened":
			emit_signal('reward_advertisement_opened')
			if debug_manager:
				debug_manager.print_debug_text_on_screen("reward advertisement opened")
		"closed":
			emit_signal('reward_advertisement_closed')
			if debug_manager:
				debug_manager.print_debug_text_on_screen("reward advertisement closed")
		"failed":
			emit_signal('reward_advertisement_failed')
			if debug_manager:
				debug_manager.print_debug_text_on_screen("reward advertisement failed")
		"rewarded":
			emit_signal('reward_advertisement_rewarded')
			if debug_manager:
				debug_manager.print_debug_text_on_screen("reward advertisement rewarded")
