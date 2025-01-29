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
	
	Bridge.advertisement.connect("rewarded_state_changed", _on_reward_state_changed)
	


func _on_interstitial_timer_timeout() -> void:
	Bridge.advertisement.show_interstitial()


func _on_interstitial_state_changed(state) -> void:
	match state:
		"opened":
			emit_signal("advertisement_opened")
		"closed":
			emit_signal("advertisement_closed")
		"failed":
			emit_signal("advertisement_failed")
	
	interstitial_timer.start()



func show_reward_advertisement() -> void:
	Bridge.advertisement.show_rewarded()


func _on_reward_state_changed(state):
	match state:
		"opened":
			emit_signal('reward_advertisement_opened')
		"closed":
			emit_signal('reward_advertisement_closed')
		"failed":
			emit_signal('reward_advertisement_failed')
		"rewarded":
			emit_signal('reward_advertisement_rewarded')
